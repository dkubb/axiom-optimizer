# encoding: utf-8

require 'spec_helper'

describe Optimizer::Function::Predicate::Exclusion::OneRight, '#optimize' do
  subject { object.optimize }

  let(:attribute) { Attribute::Integer.new(:id)    }
  let(:predicate) { attribute.exclude(operand)     }
  let(:object)    { described_class.new(predicate) }

  before do
    expect(object).to be_optimizable
  end

  context 'when the operand contains a one entry Enumerable' do
    let(:operand) { [1] }

    it { should be_kind_of(Function::Predicate::Inequality) }

    its(:left) { should be(attribute) }

    its(:right) { should == 1 }
  end

  context 'when the operand contains a one entry inclusive Range' do
    let(:operand) { 1..1 }

    it { should be_kind_of(Function::Predicate::Inequality) }

    its(:left) { should be(attribute) }

    its(:right) { should == 1 }
  end

  context 'when the operand contains a one entry exclusive Range' do
    let(:operand) { 1...2 }

    it { should be_kind_of(Function::Predicate::Inequality) }

    its(:left) { should be(attribute) }

    its(:right) { should == 1 }
  end

  context 'when the operand contains one entry after filtering invalid entries' do
    let(:operand) { ['a', 1] }

    it { should be_kind_of(Function::Predicate::Inequality) }

    its(:left) { should be(attribute) }

    its(:right) { should == 1 }
  end

  context 'when the operand contains one entry after filtering duplicate entries' do
    let(:operand) { [1, 1] }

    it { should be_kind_of(Function::Predicate::Inequality) }

    its(:left) { should be(attribute) }

    its(:right) { should == 1 }
  end
end
