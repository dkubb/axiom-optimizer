# encoding: utf-8

require 'spec_helper'

describe Algebra::Rename, '#optimize' do
  subject { object.optimize }

  let(:body)     { LazyEnumerable.new([[1, 'Dan Kubb']])                 }
  let(:relation) { Relation.new([[:id, Integer], [:name, String]], body) }
  let(:operand)  { relation                                              }
  let(:aliases)  { { id: :other_id }                                     }
  let(:object)   { described_class.new(operand, aliases)                 }

  context 'containing a relation' do
    it { should be(object) }

    it 'does not execute body#each' do
      body.should_not_receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'containing an empty relation' do
    let(:operand) { Relation.new(relation.header) }

    it { should eql(Relation.new(object.header)) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == object
    end

    it 'does not execute body#each' do
      body.should_not_receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'containing an optimizable relation' do
    let(:operand) { relation.project(relation.header) }

    it { should_not be(object) }

    it { should be_kind_of(described_class) }

    it 'sets aliases the same as the original object' do
      expect(subject.aliases).to eql(object.aliases)
    end

    its(:operand) { should be(relation) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == object
    end

    it 'does not execute body#each' do
      body.should_not_receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'containing a object operation' do
    let(:operand) { described_class.new(relation, id: :other_id) }
    let(:aliases) { { name: :other_name }                        }

    it { should_not be(object) }

    it { should be_kind_of(described_class) }

    it 'sets aliases as a union of both aliases' do
      expect(subject.aliases).to eql(described_class::Aliases.coerce(
        relation.header,
        id:   :other_id,
        name: :other_name
      ))
    end

    its(:operand) { should be(relation) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == object
    end

    it 'does not execute body#each' do
      body.should_not_receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'containing a object operation with overlapping aliases' do
    let(:operand) { described_class.new(relation, id: :other_id) }
    let(:aliases) { { other_id: :another_id }                    }

    it { should_not be(object) }

    it { should be_kind_of(described_class) }

    it 'sets aliases as a union of both aliases' do
      expect(subject.aliases).to eql(described_class::Aliases.coerce(
        relation.header,
        id: :another_id
      ))
    end

    its(:operand) { should be(relation) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == object
    end

    it 'does not execute body#each' do
      body.should_not_receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'containing an inverse object operation' do
    let(:operand) { described_class.new(relation, id: :other_id) }
    let(:aliases) { { other_id: :id }                            }

    it { should be(relation) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == object
    end

    it 'does not execute body#each' do
      body.should_not_receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'containing a projection' do
    let(:operand) { relation.project([:id]) }

    it { should be_kind_of(Algebra::Projection) }

    its(:operand) { should eql(described_class.new(relation, aliases)) }

    its(:header) { should == [[:other_id, Integer]] }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == object
    end

    it 'does not execute body#each' do
      body.should_not_receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'containing a projection, containing a object that cancels out' do
    let(:operand) { relation.rename(id: :other_id).project([:other_id]) }
    let(:aliases) { { other_id: :id }                                   }

    it 'pushes the object before the projection, and then cancel it out' do
      should eql(relation.project([:id]))
    end

    it 'returns an equivalent relation to the unoptimized operation' do
      should == object
    end

    it 'does not execute body#each' do
      body.should_not_receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'containing a restriction' do
    let(:operand) { relation.restrict { |r| r.id.eq(1) } }

    it { should be_kind_of(Algebra::Restriction) }

    its(:operand) { should eql(described_class.new(relation, aliases)) }

    its(:header) { should == [[:other_id, Integer], [:name, String]] }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == object
    end

    it 'does not execute body#each' do
      body.should_not_receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'containing a restriction, containing a object that cancels out' do
    let(:operand) { relation.rename(id: :other_id).restrict { |r| r.other_id.eq(1) } }
    let(:aliases) { { other_id: :id }                                                }

    it 'pushes the object before the restriction, and then cancel it out' do
      should eql(relation.restrict { |r| r.id.eq(1) })
    end

    it 'returns an equivalent relation to the unoptimized operation' do
      should == object
    end

    it 'does not execute body#each' do
      body.should_not_receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'containing a set operation' do
    let(:left)    { Relation.new([[:id, Integer], [:name, String]], LazyEnumerable.new([[1, 'Dan Kubb']])) }
    let(:right)   { Relation.new([[:id, Integer], [:name, String]], LazyEnumerable.new([[2, 'Dan Kubb']])) }
    let(:operand) { left.union(right)                                                                      }

    it 'pushes the object to each relation' do
      should eql(left.rename(aliases).union(right.rename(aliases)))
    end

    it 'returns an equivalent relation to the unoptimized operation' do
      should == object
    end

    it 'does not execute body#each' do
      body.should_not_receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'containing a set operation, containing a object that cancels out' do
    let(:left)    { Relation.new([[:id, Integer], [:name, String]], LazyEnumerable.new([[1, 'Dan Kubb']])) }
    let(:right)   { Relation.new([[:id, Integer], [:name, String]], LazyEnumerable.new([[2, 'Dan Kubb']])) }
    let(:operand) { left.rename(id: :other_id).union(right.rename(id: :other_id))                          }
    let(:aliases) { { other_id: :id }                                                                      }

    it 'pushes the object to each relation, then cancel it out' do
      should eql(left.union(right))
    end

    it 'returns an equivalent relation to the unoptimized operation' do
      should == object
    end

    it 'does not execute body#each' do
      body.should_not_receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'containing a reverse operation' do
    let(:limit)   { relation.sort_by { |r| [r.id, r.name] }.take(2) }
    let(:operand) { limit.reverse                                   }

    it 'pushes the object under the order, limit and reverse' do
      should eql(relation.rename(aliases).sort_by { |r| [r.other_id, r.name] }.take(2).reverse)
    end

    it 'returns an equivalent relation to the unoptimized operation' do
      should == object
    end

    it 'does not execute body#each' do
      body.should_not_receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'containing a reverse operation, containing a object that cancels out' do
    let(:limit)   { relation.sort_by { |r| [r.id, r.name] }.take(2) }
    let(:operand) { limit.rename(id: :other_id).reverse             }
    let(:aliases) { { other_id: :id }                               }

    it 'pushes the object under the order, limit and reverse, and then cancel it out' do
      should eql(relation.sort_by { |r| [r.id, r.name] }.take(2).reverse)
    end

    it 'returns an equivalent relation to the unoptimized operation' do
      should == object
    end

    it 'does not execute body#each' do
      body.should_not_receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'containing an order operation' do
    let(:operand) { relation.sort_by { |r| [r.id, r.name] } }

    it 'pushes the object under the order' do
      should eql(relation.rename(aliases).sort_by { |r| [r.other_id, r.name] })
    end

    it 'returns an equivalent relation to the unoptimized operation' do
      should == object
    end

    it 'does not execute body#each' do
      body.should_not_receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'containing an order operation, containing a object that cancels out' do
    let(:operand) { relation.rename(id: :other_id).sort_by { |r| [r.other_id, r.name] } }
    let(:aliases) { { other_id: :id }                                                   }

    it 'pushes the object under the order, and then cancel it out' do
      should eql(relation.sort_by { |r| [r.id, r.name] })
    end

    it 'returns an equivalent relation to the unoptimized operation' do
      should == object
    end

    it 'does not execute body#each' do
      body.should_not_receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'containing a limit operation' do
    let(:order)   { relation.sort_by { |r| [r.id, r.name] } }
    let(:operand) { order.take(2)                           }

    it 'pushes the object under the limit and order' do
      should eql(relation.rename(aliases).sort_by { |r| [r.other_id, r.name] }.take(2))
    end

    it 'returns an equivalent relation to the unoptimized operation' do
      should == object
    end

    it 'does not execute body#each' do
      body.should_not_receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'containing a limit operation, containing a object that cancels out' do
    let(:order)   { relation.sort_by { |r| [r.id, r.name] } }
    let(:operand) { order.rename(id: :other_id).take(2)     }
    let(:aliases) { { other_id: :id }                       }

    it 'pushes the object under the limit and order, and then cancel it out' do
      should eql(relation.sort_by { |r| [r.id, r.name] }.take(2))
    end

    it 'returns an equivalent relation to the unoptimized operation' do
      should == object
    end

    it 'does not execute body#each' do
      body.should_not_receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'containing an offset operation' do
    let(:order)   { relation.sort_by { |r| [r.id, r.name] } }
    let(:operand) { order.drop(1)                           }

    it 'pushes the object under the offset and order' do
      should eql(relation.rename(aliases).sort_by { |r| [r.other_id, r.name] }.drop(1))
    end

    it 'returns an equivalent relation to the unoptimized operation' do
      should == object
    end

    it 'does not execute body#each' do
      body.should_not_receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'containing an offset operation, containing a object that cancels out' do
    let(:order)   { relation.sort_by { |r| [r.id, r.name] } }
    let(:operand) { order.rename(id: :other_id).drop(1)     }
    let(:aliases) { { other_id: :id }                       }

    it 'pushes the object under the offset and order, and then cancel it out' do
      should eql(relation.sort_by { |r| [r.id, r.name] }.drop(1))
    end

    it 'returns an equivalent relation to the unoptimized operation' do
      should == object
    end

    it 'does not execute body#each' do
      body.should_not_receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'containing a materialized relation' do
    let(:operand) { Relation.new([[:id, Integer], [:name, String]], [[1, 'Dan Kubb']]) }

    it { should eql(Relation::Materialized.new([[:other_id, Integer], [:name, String]], [[1, 'Dan Kubb']])) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == object
    end

    it_should_behave_like 'an optimize method'
  end
end
