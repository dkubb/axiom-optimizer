# encoding: utf-8

require 'spec_helper'

describe Optimizer::Function::Unary::ConstantOperand, '#optimize' do
  subject { object.optimize }

  let(:described_class) { Class.new(Optimizer) { include Optimizer::Function::Unary } }
  let(:function)        { Function::Numeric::Absolute.new(-1)                         }
  let(:object)          { described_class.new(function)                               }

  before do
    described_class.class_eval { include Optimizer::Function::Unary::ConstantOperand }
    object.should be_optimizable
  end

  it { should be(1) }
end
