# encoding: utf-8

require 'spec_helper'

describe Optimizer::Function::Unary, '#operand' do
  subject { object.operand }

  let(:described_class) { Class.new(Optimizer) { include Optimizer::Function::Unary }  }
  let(:function)        { Class.new(Function) { include Function::Unary }.new(operand) }
  let(:object)          { described_class.new(function)                                }

  context 'when the operand is frozen' do
    let(:operand) { 'Operand'.freeze }

    it { should be(operand) }
  end

  context 'when the operand is not frozen' do
    let(:operand) { 'Operand' }

    it { should_not be(operand) }

    it { should be_frozen }

    it { should == operand }
  end
end
