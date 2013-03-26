# encoding: utf-8

require 'spec_helper'

describe Optimizer::Function::Connective::Negation::InvertibleOperand, '#optimizable?' do
  subject { object.optimizable? }

  let(:attribute) { Attribute::Integer.new(:id)                 }
  let(:negation)  { Function::Connective::Negation.new(operand) }
  let(:object)    { described_class.new(negation)               }

  before do
    object.operation.should be_kind_of(Function::Connective::Negation)
  end

  context 'when operand is invertible' do
    let(:operand) { attribute.eq(1) }

    it { should be(true) }
  end

  context 'when operand is not invertible' do
    let(:operand) { proc { true } }

    it { should be(false) }
  end

end
