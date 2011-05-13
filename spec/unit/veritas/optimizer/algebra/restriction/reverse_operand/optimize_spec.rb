# encoding: utf-8

require 'spec_helper'

describe Optimizer::Algebra::Restriction::ReverseOperand, '#optimize' do
  subject { object.optimize }

  let(:order)     { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ].each).order }
  let(:predicate) { order[:id].eq(1)                                         }
  let(:relation)  { order.take(2).reverse.restrict { predicate }             }
  let(:object)    { described_class.new(relation)                            }

  before do
    object.should be_optimizable
  end

  it { should be_kind_of(Relation::Operation::Reverse) }

  its(:operand) { should eql(order.take(2).restrict { predicate }) }
end
