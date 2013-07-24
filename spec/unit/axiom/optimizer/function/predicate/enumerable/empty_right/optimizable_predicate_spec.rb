# encoding: utf-8

require 'spec_helper'

describe Optimizer::Function::Predicate::Enumerable::EmptyRight, '#optimizable?' do
  subject { object.optimizable? }

  let(:described_class) { Class.new(Optimizer::Function::Predicate) }
  let(:attribute)       { Attribute::Integer.new(:id, size: 1..9)   }
  let(:predicate)       { attribute.include(operand)                }
  let(:object)          { described_class.new(predicate)            }

  before do
    described_class.class_eval { include Optimizer::Function::Predicate::Enumerable::EmptyRight }

    expect(predicate).to be_kind_of(Function::Predicate::Enumerable)
  end

  context 'when the operand contains a nil' do
    let(:operand) { nil }

    it { should be(true) }
  end

  context 'when the operand contains an empty Enumerable' do
    let(:operand) { [] }

    it { should be(true) }
  end

  context 'when the operand contains an empty inclusive Range' do
    let(:operand) { 1..0 }

    it { should be(true) }
  end

  context 'when the operand contains an empty exclusive Range' do
    let(:operand) { 1...1 }

    it { should be(true) }
  end

  context 'when the operand is empty after filtering invalid entries' do
    let(:operand) { ['a'] }

    it { should be(true) }
  end

  context 'when the operand contains an not empty Enumerable' do
    let(:operand) { [1] }

    it { should be(false) }
  end

  context 'when the operand contains an not empty inclusive Range' do
    let(:operand) { 1..1 }

    it { should be(false) }
  end

  context 'when the operand contains an not empty exclusive Range' do
    let(:operand) { 1...2 }

    it { should be(false) }
  end

  context 'when the operand is not empty after filtering invalid entries' do
    let(:operand) { ['a', 1] }

    it { should be(false) }
  end

  context 'when the operand contains a Range outside of the allowed values' do
    let(:operand) { 10..100 }

    it { should be(true) }
  end
end
