# encoding: utf-8

require 'spec_helper'

describe Optimizer::Function::Unary::UnoptimizedOperand, '#optimize' do
  subject { object.optimize }

  let(:described_class) { Class.new(Optimizer) { include Optimizer::Function::Unary }         }
  let(:function)        { Function::Numeric::Absolute.new(Function::Numeric::Absolute.new(1)) }
  let(:object)          { described_class.new(function)                                       }

  before do
    described_class.class_eval { include Optimizer::Function::Unary::UnoptimizedOperand }
    expect(object).to be_optimizable
  end

  it { should eql(Function::Numeric::Absolute.new(1)) }
end
