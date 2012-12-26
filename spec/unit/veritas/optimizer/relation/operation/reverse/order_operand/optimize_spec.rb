# encoding: utf-8

require 'spec_helper'

describe Optimizer::Relation::Operation::Reverse::OrderOperand, '#optimize' do
  subject { object.optimize }

  let(:base)     { Relation.new([ [ :id, Integer ] ], LazyEnumerable.new([ [ 1 ] ])) }
  let(:operand)  { base.sort_by { |r| r.id }                                         }
  let(:relation) { operand.reverse                                                   }
  let(:object)   { described_class.new(relation)                                     }

  before do
    object.should be_optimizable
  end

  it { should be_kind_of(Relation::Operation::Order) }

  its(:operand) { should equal(base) }

  its(:directions) { should equal(relation.directions) }
end
