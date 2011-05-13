require 'spec_helper'

describe Optimizer::Function::Predicate::ConstantOperands, '#optimizable?' do
  subject { object.optimizable? }

  let(:predicate) { Function::Predicate::Equality.new(left, right) }
  let(:object)    { described_class.new(predicate)                 }

  context 'when left and right are constants' do
    let(:left)  { 1 }
    let(:right) { 1 }

    it { should be(true) }
  end

  context 'when left is a constant, and right is not a constant' do
    let(:left)  { 1                                         }
    let(:right) { Function::Proposition::Tautology.instance }

    it { should be(false) }
  end

  context 'when left is not a constant, and right is a constant' do
    let(:left)  { Function::Proposition::Tautology.instance }
    let(:right) { 1                                         }

    it { should be(false) }
  end
end
