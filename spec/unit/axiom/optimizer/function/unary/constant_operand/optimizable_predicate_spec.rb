# encoding: utf-8

require 'spec_helper'

describe Optimizer::Function::Unary::ConstantOperand, '#optimizable?' do
  subject { object.optimizable? }

  let(:described_class) { Class.new(Optimizer) { include Optimizer::Function::Unary }  }
  let(:function)        { Class.new(Function) { include Function::Unary }.new(operand) }
  let(:object)          { described_class.new(function)                                }

  before do
    described_class.class_eval { include Optimizer::Function::Unary::ConstantOperand }
  end

  context 'when the operand is a constant' do
    let(:operand) { 1 }

    it { should be(true) }
  end

  context 'when the operand is not a constant' do
    let(:operand) { proc { } }

    it { should be(false) }
  end
end
