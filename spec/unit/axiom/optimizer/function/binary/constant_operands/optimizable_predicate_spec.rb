# encoding: utf-8

require 'spec_helper'

describe Optimizer::Function::Binary::ConstantOperands, '#optimizable?' do
  subject { object.optimizable? }

  let(:described_class) { Class.new(Optimizer) { include Optimizer::Function::Binary }       }
  let(:function)        { Class.new(Function)  { include Function::Binary }.new(left, right) }
  let(:object)          { described_class.new(function)                                      }

  before do
    described_class.class_eval { include Optimizer::Function::Binary::ConstantOperands }
  end

  context 'when left and right are constants' do
    let(:left)  { 1 }
    let(:right) { 1 }

    it { should be(true) }
  end

  context 'when left is a constant, and right is not a constant' do
    let(:left)  { 1       }
    let(:right) { proc {} }

    it { should be(false) }
  end

  context 'when left is not a constant, and right is a constant' do
    let(:left)  { proc {} }
    let(:right) { 1       }

    it { should be(false) }
  end
end
