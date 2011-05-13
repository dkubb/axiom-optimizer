require 'spec_helper'

describe Optimizer::Function::Predicate::Inclusion::OneRightOperand, '#optimize' do
  subject { object.optimize }

  let(:attribute) { Attribute::Integer.new(:id)    }
  let(:predicate) { attribute.include(operand)     }
  let(:object)    { described_class.new(predicate) }

  before do
    object.should be_optimizable
  end

  context 'when the operand contains a one entry Enumerable' do
    let(:operand) { [ 1 ] }

    it { should be_kind_of(Function::Predicate::Equality) }

    its(:left) { should equal(attribute) }

    its(:right) { should == 1 }

  end

  context 'when the operand contains a one entry inclusive Range' do
    let(:operand) { 1..1 }

    it { should be_kind_of(Function::Predicate::Equality) }

    its(:left) { should equal(attribute) }

    its(:right) { should == 1 }
  end

  context 'when the operand contains a one entry exclusive Range' do
    let(:operand) { 1...2 }

    it { should be_kind_of(Function::Predicate::Equality) }

    its(:left) { should equal(attribute) }

    its(:right) { should == 1 }
  end

  context 'when the operand contains one entry after filtering invalid entries' do
    let(:operand) { [ 'a', 1 ] }

    it { should be_kind_of(Function::Predicate::Equality) }

    its(:left) { should equal(attribute) }

    its(:right) { should == 1 }
  end

  context 'when the operand contains one entry after filtering duplicate entries' do
    let(:operand) { [ 1, 1 ] }

    it { should be_kind_of(Function::Predicate::Equality) }

    its(:left) { should equal(attribute) }

    its(:right) { should == 1 }
  end
end
