# encoding: utf-8

require 'spec_helper'

describe Optimizer::Relation::Operation::Order::UnoptimizedOperand, '#optimize' do
  subject { object.optimize }

  let(:base)     { Relation.new([ [ :id, Integer ] ], LazyEnumerable.new([ [ 1 ] ])) }
  let(:relation) { base.rename({}).sort_by { |r| r.id }                              }
  let(:object)   { described_class.new(relation)                                     }

  before do
    object.should be_optimizable
  end

  it { should be_kind_of(Relation::Operation::Order) }

  it { should_not equal(relation) }

  its(:operand) { should equal(base) }

  its(:directions) { should equal(relation.directions) }
end