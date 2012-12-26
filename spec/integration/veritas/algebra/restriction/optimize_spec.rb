# encoding: utf-8

require 'spec_helper'

describe Algebra::Restriction, '#optimize' do
  subject { object.optimize }

  let(:body)     { LazyEnumerable.new([ [ 1 ] ])            }
  let(:relation) { Relation.new([ [ :id, Integer ] ], body) }
  let(:operand)  { relation                                 }
  let(:object)   { described_class.new(operand, predicate)  }

  context 'with a tautology' do
    let(:predicate) { Function::Proposition::Tautology.instance }

    it { should equal(relation) }

    it 'does not execute body#each' do
      body.should_not_receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'with a contradiction' do
    let(:predicate) { Function::Proposition::Contradiction.instance }

    it { should eql(Relation::Empty.new(relation.header)) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == object
    end

    it 'does not execute body#each' do
      body.should_not_receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'with a predicate' do
    let(:predicate) { relation[:id].eq(1) }

    it { should equal(object) }

    it 'does not execute body#each' do
      body.should_not_receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'with an optimizable predicate' do
    let(:predicate) { relation[:id].eq(1).and(Function::Proposition::Tautology.instance) }

    it { should_not equal(object) }

    it { should be_kind_of(described_class) }

    its(:predicate) { should eql(relation[:id].eq(1)) }

    its(:operand) { should equal(relation) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == object
    end

    it 'does not execute body#each' do
      body.should_not_receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'with an optimizable operand' do
    let(:operand)    { relation.project(relation.header) }
    let(:predicate)  { relation[:id].eq(1)               }

    it { should_not equal(object) }

    it { should be_kind_of(described_class) }

    its(:predicate) { should equal(predicate) }

    its(:operand) { should equal(relation) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == object
    end

    it 'does not execute body#each' do
      body.should_not_receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'with an empty relation' do
    let(:operand)   { Relation::Empty.new([ [ :id, Integer ] ]) }
    let(:predicate) { operand[:id].gte(1)                       }

    it { should equal(operand) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == object
    end

    it 'does not execute body#each' do
      body.should_not_receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'with an empty relation when optimized' do
    let(:operand)   { described_class.new(relation, Function::Proposition::Contradiction.instance) }
    let(:predicate) { operand[:id].gte(1)                                                          }

    it { should eql(Relation::Empty.new(relation.header)) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == object
    end

    it 'does not execute body#each' do
      body.should_not_receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'with a restriction' do
    let(:other_predicate) { relation[:id].lt(2)                            }
    let(:operand)         { described_class.new(relation, other_predicate) }
    let(:predicate)       { operand[:id].gte(1)                            }

    it { should_not equal(object) }

    it { should be_kind_of(described_class) }

    its(:predicate) { should eql(other_predicate & predicate) }

    its(:operand) { should equal(relation) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == object
    end

    it 'does not execute body#each' do
      body.should_not_receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'with a set operation' do
    let(:left)      { Relation.new([ [ :id, Integer ] ], LazyEnumerable.new([ [ 1 ] ])) }
    let(:right)     { Relation.new([ [ :id, Integer ] ], LazyEnumerable.new([ [ 2 ] ])) }
    let(:operand)   { left.union(right)                                                 }
    let(:predicate) { operand[:id].gte(1)                                               }

    it 'pushes the object to each relation' do
      should eql(left.restrict { |r| r.id.gte(1) }.union(right.restrict { |r| r.id.gte(1) }))
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

  context 'with an order operation' do
    let(:operand)   { relation.sort_by { |r| r.id } }
    let(:predicate) { operand[:id].gte(1)           }

    it 'cancels out the order' do
      should eql(relation.restrict { predicate })
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
    let(:operand)   { Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ] ]) }
    let(:predicate) { operand[:id].eq(1)                                   }

    it { should eql(Relation::Materialized.new([ [ :id, Integer ] ], [ [ 1 ] ])) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == object
    end

    it_should_behave_like 'an optimize method'
  end
end
