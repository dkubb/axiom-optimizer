# encoding: utf-8

require 'spec_helper'

describe Optimizer::Function::Predicate::Exclusion::EmptyRight, '#optimize' do
  subject { object.optimize }

  let(:attribute) { Attribute::Integer.new(:id)    }
  let(:predicate) { attribute.exclude(operand)     }
  let(:object)    { described_class.new(predicate) }

  before do
    expect(object).to be_optimizable
  end

  context 'when the operand contains a nil' do
    let(:operand) { nil }

    it { should be(Function::Proposition::Tautology.instance) }
  end

  context 'when the operand contains an empty Enumerable' do
    let(:operand) { [] }

    it { should be(Function::Proposition::Tautology.instance) }
  end

  context 'when the operand contains an empty inclusive Range' do
    let(:operand) { 1..0 }

    it { should be(Function::Proposition::Tautology.instance) }
  end

  context 'when the operand contains an empty exclusive Range' do
    let(:operand) { 1...1 }

    it { should be(Function::Proposition::Tautology.instance) }
  end

  context 'when the operand is empty after filtering invalid entries' do
    let(:operand) { ['a'] }

    it { should be(Function::Proposition::Tautology.instance) }
  end
end
