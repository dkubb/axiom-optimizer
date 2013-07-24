# encoding: utf-8

require 'spec_helper'

describe Optimizer::Function::Connective::Conjunction::OptimizableToExclusion, '#optimizable?' do
  subject { object.optimizable? }

  let(:attribute)  { Attribute::Integer.new(:id)     }
  let(:connective) { left.and(right)                 }
  let(:object)     { described_class.new(connective) }

  before do
    expect(object.operation).to be_kind_of(Function::Connective::Conjunction)
  end

  context 'when the operands are optimizable' do
    context 'when the left and right are equality predicates' do
      let(:left)  { attribute.ne(2) }
      let(:right) { attribute.ne(1) }

      it { should be(true) }
    end

    context 'when the left is an equality predicate and the right is an inclusion predicate' do
      let(:left)  { attribute.ne(2)           }
      let(:right) { attribute.exclude([1, 3]) }

      it { should be(true) }
    end

    context 'when the left is an inclusion predicate and the right is an equality predicate' do
      let(:left)  { attribute.exclude([2, 3]) }
      let(:right) { attribute.ne(1)           }

      it { should be(true) }
    end

    context 'when the left and right are inclusion predicatess' do
      let(:left)  { attribute.exclude([2, 3]) }
      let(:right) { attribute.exclude([1, 3]) }

      it { should be(true) }
    end
  end

  context 'when the operands are not optimizable' do
    context 'when the left is an inequality predicate and the right is an equality predicate' do
      let(:left)  { attribute.ne(1) }
      let(:right) { attribute.eq(2) }

      it { should be(false) }
    end

    context 'when the left is an exclusion predicate and the right is an equality predicate' do
      let(:left)  { attribute.exclude([1, 3]) }
      let(:right) { attribute.eq(2)           }

      it { should be(false) }
    end
  end
end
