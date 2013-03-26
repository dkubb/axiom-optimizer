# encoding: utf-8

require 'spec_helper'

describe Optimizer::Function::Predicate::Comparable::NeverComparable, '#optimizable?' do
  subject { object.optimizable? }

  let(:described_class) { Class.new(Optimizer::Function::Predicate)      }
  let(:attribute)       { Attribute::Integer.new(:id)                    }
  let(:predicate)       { Function::Predicate::Equality.new(left, right) }
  let(:object)          { described_class.new(predicate)                 }

  before do
    described_class.class_eval { include Optimizer::Function::Predicate::Comparable::NeverComparable }

    predicate.should be_kind_of(Function::Predicate::Comparable)
  end

  context 'when left is a constant and is valid' do
    let(:left)  { 1         }
    let(:right) { attribute }

    it { should be(false) }
  end

  context 'when left is a constand and is not valid' do
    let(:left)  { 'a'       }
    let(:right) { attribute }

    it { should be(true) }
  end

  context 'when right is a constant and is valid' do
    let(:left)  { attribute }
    let(:right) { 1         }

    it { should be(false) }
  end

  context 'when right is a constant and is not valid' do
    let(:left)  { attribute }
    let(:right) { 'a'       }

    it { should be(true) }
  end

  context 'when left and right are comparable' do
    let(:left)  { attribute }
    let(:right) { attribute }

    it { should be(false) }
  end

  context 'when left and right are not comparable' do
    let(:left)  { attribute                    }
    let(:right) { Attribute::String.new(:name) }

    it { should be(true) }
  end

  context 'when left is nil' do
    let(:left)  { nil       }
    let(:right) { attribute }

    it { should be(true) }
  end

  context 'when right is nil' do
    let(:left)  { attribute }
    let(:right) { nil       }

    it { should be(true) }
  end
end
