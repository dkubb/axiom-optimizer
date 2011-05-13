# encoding: utf-8

require 'spec_helper'

describe Optimizer::Relation::Operation::Reverse::OrderOperand, '#optimizable?' do
  subject { object.optimizable? }

  let(:base)     { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ].each) }
  let(:relation) { operand.reverse                                    }
  let(:object)   { described_class.new(relation)                      }

  before do
    object.operation.should be_kind_of(Relation::Operation::Reverse)
  end

  context 'when the operand is ordered' do
    let(:operand) { base.order }

    it { should be(true) }
  end

  context 'when the operand is not ordered' do
    let(:operand) { base.order.take(2) }

    it { should be(false) }
  end
end
