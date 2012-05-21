# encoding: utf-8

require 'spec_helper'

describe Optimizer::Algebra::Join::MaterializedRight, '#optimize' do
  subject { object.optimize }

  let(:relation) { left.join(right)              }
  let(:object)   { described_class.new(relation) }

  before do
    object.should be_optimizable
  end

  context 'with no joined tuples' do
    let(:left)  { Relation.new([ [ :id, Integer ],                    ], [].each) }
    let(:right) { Relation.new([ [ :id, Integer ], [ :age,  Integer ] ], [])      }

    it { should be_kind_of(Algebra::Join) }

    its(:left) { should eql(left.restrict { Function::Proposition::Contradiction.instance }) }

    its(:right) { should eql(Relation::Empty.new(right.header)) }
  end

  context 'with one joined tuple' do
    let(:left)  { Relation.new([ [ :id, Integer ],                    ], [ [ 1,    ] ].each) }
    let(:right) { Relation.new([ [ :id, Integer ], [ :age,  Integer ] ], [ [ 1, 35 ] ])      }

    it { should be_kind_of(Algebra::Join) }

    its(:left) { should eql(left.restrict { |r| r.id.eq(1) }) }

    its(:right) { should equal(right) }

    it 'is not further optimizable' do
      described_class.new(subject).should_not be_optimizable
    end
  end

  context 'with two or more joined tuples' do
    let(:left)  { Relation.new([ [ :id, Integer ],                    ], [ [ 1,    ], [ 2,    ] ].each) }
    let(:right) { Relation.new([ [ :id, Integer ], [ :age,  Integer ] ], [ [ 1, 35 ], [ 2, 25 ] ])      }

    it { should be_kind_of(Algebra::Join) }

    its(:left) { should eql(left.restrict { |r| r.id.include([ 1, 2 ]) }) }

    its(:right) { should equal(right) }

    it 'is not further optimizable' do
      described_class.new(subject).should_not be_optimizable
    end
  end
end
