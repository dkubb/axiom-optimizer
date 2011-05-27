# encoding: utf-8

require 'spec_helper'

describe Optimizer::Relation::Operation::Binary::UnoptimizedOperands, '#optimize' do
  subject { object.optimize }

  let(:left)     { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ].each) }
  let(:right)    { Relation.new([ [ :id, Integer ] ], [ [ 2 ] ].each) }
  let(:relation) { left.rename({}).union(right.rename({}))            }
  let(:object)   { described_class.new(relation)                      }

  before do
    object.should be_optimizable
  end

  it { should be_kind_of(Algebra::Union) }

  it { should_not equal(relation) }

  its(:left) { should equal(left) }

  its(:right) { should equal(right) }
end
