# encoding: utf-8

require 'spec_helper'

describe Optimizer::Relation::Operation::Unary::OrderOperand, '#optimizable?' do
  subject { object.optimizable? }

  let(:described_class) { Class.new(Optimizer::Relation::Operation::Unary) }
  let(:base)            { Relation.new([ [ :id, Integer ] ], [].each)      }
  let(:relation)        { operand.project([])                              }
  let(:object)          { described_class.new(relation)                    }

  before do
    described_class.class_eval { include Optimizer::Relation::Operation::Unary::OrderOperand }
  end

  context 'when operand is an order' do
    let(:operand) { base.sort_by { |r| r[:id] } }

    it { should be(true) }
  end

  context 'when operand is not an order' do
    let(:operand) { base }

    it { should be(false) }
  end
end
