# encoding: utf-8

require 'spec_helper'

describe Optimizer::Function::Predicate::Enumerable::UnoptimizedOperands, '#optimize' do
  subject { object.optimize }

  let(:attribute) { Attribute::Integer.new(:id)    }
  let(:predicate) { attribute.include(operand)     }
  let(:object)    { described_class.new(predicate) }

  before do
    object.should be_optimizable
  end

  context 'when the operand contains an unsorted Enumerable' do
    let(:operand) { [ 2, 1 ] }

    it { should be_kind_of(Function::Predicate::Inclusion) }

    its(:left) { should equal(attribute) }

    its(:right) { should == [ 1, 2 ] }
  end

  context 'when the operand contains an Enumerable with boolean values' do
    let(:attribute) { Attribute::Boolean.new(:status) }
    let(:operand)   { [ true, false ]                 }

    it { should be_kind_of(Function::Predicate::Inclusion) }

    its(:left) { should equal(attribute) }

    its(:right) { should == [ false, true ] }
  end

  context 'when the operand contains an exclusive Range' do
    let(:operand) { 1...3 }

    it { should be_kind_of(Function::Predicate::Inclusion) }

    its(:left) { should equal(attribute) }

    its(:right) { should == (1..2) }
  end

  context 'when the operand contains an Enumerable after filtering invalid entries' do
    let(:operand) { [ 'a', 1, 2 ] }

    it { should be_kind_of(Function::Predicate::Inclusion) }

    its(:left) { should equal(attribute) }

    its(:right) { should == [ 1, 2 ] }
  end

  context 'when the operand contains an Enumerable after filtering duplicate entries' do
    let(:operand) { [ 1, 1, 2, 2 ] }

    it { should be_kind_of(Function::Predicate::Inclusion) }

    its(:left) { should equal(attribute) }

    its(:right) { should == [ 1, 2 ] }
  end
end
