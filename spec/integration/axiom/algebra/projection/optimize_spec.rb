# encoding: utf-8

require 'spec_helper'

describe Algebra::Projection, '#optimize' do
  subject { object.optimize }

  let(:header)   { [[:id, Integer], [:name, String], [:age, Integer]] }
  let(:body)     { LazyEnumerable.new([[1, 'Dan Kubb', 35]])          }
  let(:relation) { Relation.new(header, body)                         }
  let(:operand)  { relation                                           }
  let(:object)   { described_class.new(operand, attributes)           }

  before do
    # skip dup of the body to avoid clearing the method stubs
    allow(body).to receive(:frozen?).and_return(true)
  end

  context 'when the attributes are equivalent to the relation headers, and in the same order' do
    let(:attributes) { header }

    it { should be(operand) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == object
    end

    it 'does not execute body#each' do
      expect(body).not_to receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'when the attributes are equivalent to the relation headers, and not in the same order' do
    let(:attributes) { [:name, :id] }

    it 'does not factor out the object, because tuple order is currently significant' do
      should be(object)
    end

    it 'does not execute body#each' do
      expect(body).not_to receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'when the attributes are different from the relation headers' do
    let(:attributes) { [:id] }

    it { should be(object) }

    it 'does not execute body#each' do
      expect(body).not_to receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'containing an empty relation' do
    let(:operand)    { Relation::Empty.new(header) }
    let(:attributes) { [:id]                       }

    it { should eql(Relation::Empty.new(object.header)) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == object
    end

    it_should_behave_like 'an optimize method'
  end

  context 'containing an empty relation when optimized' do
    let(:operand)    { Algebra::Restriction.new(relation, Function::Proposition::Contradiction.instance) }
    let(:attributes) { [:id]                                                                             }

    it { should eql(Relation::Empty.new(object.header)) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == object
    end

    it 'does not execute body#each' do
      expect(body).not_to receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'containing an optimizable relation' do
    let(:operand)    { Algebra::Restriction.new(relation, Function::Proposition::Tautology.instance) }
    let(:attributes) { [:id]                                                                         }

    it { should_not be(object) }

    it { should be_kind_of(described_class) }

    its(:operand) { should be(relation) }

    its(:header) { should == object.header }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == object
    end

    it 'does not execute body#each' do
      expect(body).not_to receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'containing a projection' do
    let(:operand)    { relation.project([:id, :name]) }
    let(:attributes) { [:id]                          }

    it { should_not be(object) }

    it { should be_kind_of(described_class) }

    its(:operand) { should be(relation) }

    its(:header) { should == object.header }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == object
    end

    it 'does not execute body#each' do
      expect(body).not_to receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'containing a set operation' do
    let(:left)       { Relation.new([[:id, Integer], [:name, String]], LazyEnumerable.new([[1, 'Dan Kubb']])) }
    let(:right)      { Relation.new([[:id, Integer], [:name, String]], LazyEnumerable.new([[2, 'Dan Kubb']])) }
    let(:operand)    { left.union(right)                                                                      }
    let(:attributes) { [:name]                                                                                }

    it 'pushes the object to each relation' do
      should eql(Algebra::Union.new(
         described_class.new(left, object.header),
         described_class.new(right, object.header)
      ))
    end

    it 'returns an equivalent relation to the unoptimized operation' do
      should == object
    end

    it 'does not execute body#each' do
      expect(body).not_to receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'containing a set operation containing a projection of relations' do
    let(:left_body)  { LazyEnumerable.new([[1, 'Dan Kubb', 35]])                     }
    let(:right_body) { LazyEnumerable.new([[2, 'Dan Kubb', 35]])                     }
    let(:left)       { Relation.new(header, left_body)                               }
    let(:right)      { Relation.new(header, right_body)                              }
    let(:operand)    { left.project([:id, :name]).union(right.project([:id, :name])) }
    let(:attributes) { [:name]                                                       }

    before do
      # skip dup of the left and right body to avoid clearing the method stubs
      allow(left_body).to receive(:frozen?).and_return(true)
      allow(right_body).to receive(:frozen?).and_return(true)
    end

    it 'pushes the object to each relation, and combine the nested objects' do
      should eql(left.project([:name]).union(right.project([:name])))
    end

    it 'returns an equivalent relation to the unoptimized operation' do
      should == object
    end

    it 'does not execute left_body#each' do
      pending 'TODO: should only compare left and right with #eql? if they are materialized' do
        expect(left_body).to_not receive(:each)
        subject
      end
    end

    it 'does not execute right_body#each' do
      pending 'TODO: should only compare left and right with #eql? if they are materialized' do
        expect(right_body).to_not receive(:each)
        subject
      end
    end

    it_should_behave_like 'an optimize method'
  end

  context 'containing a set operation containing a projection of materialized relations' do
    let(:left_body)  { [[1, 'Dan Kubb', 35]]                                         }
    let(:right_body) { [[2, 'Dan Kubb', 35]]                                         }
    let(:left)       { Relation.new(header, left_body)                               }
    let(:right)      { Relation.new(header, right_body)                              }
    let(:operand)    { left.project([:id, :name]).union(right.project([:id, :name])) }
    let(:attributes) { [:name]                                                       }

    it 'pushes the object to each relation, and combine the nested objects, then materializes' do
      should eql(Relation.new([[:name, String]], [['Dan Kubb']]))
    end

    it 'returns an equivalent relation to the unoptimized operation' do
      should == object
    end

    it 'executes left_body#each' do
      pending 'TODO: make sure this is only received once'
      expect(left_body).to receive(:each)
      subject
    end

    it 'executes right_body#each' do
      pending 'TODO: make sure this is only received once'
      expect(right_body).to receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'containing a materialized relation' do
    let(:operand)    { Relation.new(header, [[1, 'Dan Kubb', 35]]) }
    let(:attributes) { [:id]                                       }

    it { should eql(Relation::Materialized.new([[:id, Integer]], [[1]])) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == object
    end

    it_should_behave_like 'an optimize method'
  end
end
