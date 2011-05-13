# encoding: utf-8

require 'spec_helper'

describe Optimizer::Function::Predicate::Enumerable::OneRightOperand, '#optimizable?' do
  subject { object.optimizable? }

  let(:described_class) { Class.new(Optimizer::Function::Predicate) }
  let(:attribute)       { Attribute::Integer.new(:id)               }
  let(:predicate)       { attribute.include(operand)                }
  let(:object)          { described_class.new(predicate)            }

  before do
    described_class.class_eval { include Optimizer::Function::Predicate::Enumerable::OneRightOperand }

    predicate.should be_kind_of(Function::Predicate::Enumerable)
  end

  context 'when the operand contains a one entry Enumerable' do
    let(:operand) { [ 1 ] }

    it { should be(true) }
  end

  context 'when the operand contains a one entry inclusive Range' do
    let(:operand) { 1..1 }

    it { should be(true) }
  end

  context 'when the operand contains a one entry exclusive Range' do
    let(:operand) { 1...2 }

    it { should be(true) }
  end

  context 'when the operand contains one entry after filtering invalid entries' do
    let(:operand) { [ 'a', 1 ] }

    it { should be(true) }
  end

  context 'when the operand contains one entry after filtering duplicate entries' do
    let(:operand) { [ 1, 1 ] }

    it { should be(true) }
  end

  context 'when the operand contains a more than one entry Enumerable' do
    let(:operand) { [ 2, 1 ] }

    it { should be(false) }
  end

  context 'when the operand contains a more than one entry inclusive Range' do
    let(:operand) { 1..2 }

    it { should be(false) }
  end

  context 'when the operand contains a more than one entry exclusive Range' do
    let(:operand) { 1...3 }

    it { should be(false) }
  end

  context 'when the operand contains more than one entry after filtering invalid entries' do
    let(:operand) { [ 'a', 1, 2 ] }

    it { should be(false) }
  end

  context 'when the operand contains more than one entry after filtering duplicate entries' do
    let(:operand) { [ 2, 1, 2, 1 ] }

    it { should be(false) }
  end
end
