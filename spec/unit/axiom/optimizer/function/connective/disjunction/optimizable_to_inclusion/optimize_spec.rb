# encoding: utf-8

require 'spec_helper'

describe Optimizer::Function::Connective::Disjunction::OptimizableToInclusion, '#optimize' do
  subject { object.optimize }

  let(:attribute)  { Attribute::Integer.new(:id)     }
  let(:connective) { left.or(right)                  }
  let(:object)     { described_class.new(connective) }

  before do
    expect(object).to be_optimizable
  end

  context 'when the right operands are optimizable' do
    context 'when the left and right are equality predicates' do
      let(:left)  { attribute.eq(2) }
      let(:right) { attribute.eq(1) }

      it { should be_kind_of(Function::Predicate::Inclusion) }

      its(:left) { should be(attribute) }

      # enumerable order is normalized
      its(:right) { should == [ 1, 2 ] }
    end

    context 'when the left is an equality predicate and the right is an inclusion predicate' do
      let(:left)  { attribute.eq(2)          }
      let(:right) { attribute.include([ 1 ]) }

      it { should be_kind_of(Function::Predicate::Inclusion) }

      its(:left) { should be(attribute) }

      # enumerable order is normalized
      its(:right) { should == [ 1, 2 ] }
    end

    context 'when the left is an inclusion predicate and the right is an equality predicate' do
      let(:left)  { attribute.include([ 2 ]) }
      let(:right) { attribute.eq(1)          }

      it { should be_kind_of(Function::Predicate::Inclusion) }

      its(:left) { should be(attribute) }

      # enumerable order is normalized
      its(:right) { should == [ 1, 2 ] }
    end

    context 'when the left and right are inclusion predicatess' do
      let(:left)  { attribute.include([ 2 ]) }
      let(:right) { attribute.include([ 1 ]) }

      it { should be_kind_of(Function::Predicate::Inclusion) }

      its(:left) { should be(attribute) }

      # enumerable order is normalized
      its(:right) { should == [ 1, 2 ] }
    end
  end

  context 'when the right operands are not optimizable' do
    let(:left)  { attribute.eq(1) }
    let(:right) { attribute.eq(2) }

    it { should be_kind_of(Function::Predicate::Inclusion) }

    its(:left) { should be(attribute) }

    its(:right) { should == [ 1, 2 ] }
  end
end
