# encoding: utf-8

require 'spec_helper'

describe Optimizer::Algebra::Extension::OrderOperand, '#optimizable?' do
  subject { object.optimizable? }

  let(:base)     { Relation.new([ [ :id, Integer ] ], [].each) }
  let(:relation) { operand.extend {}                           }
  let(:object)   { described_class.new(relation)               }

  context 'when operand is an order' do
    let(:operand) { base.order }

    it { should be(true) }
  end

  context 'when operand is not an order' do
    let(:operand) { base }

    it { should be(false) }
  end
end
