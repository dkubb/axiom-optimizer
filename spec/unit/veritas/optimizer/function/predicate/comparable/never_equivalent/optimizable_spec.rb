require 'spec_helper'

describe Optimizer::Function::Predicate::Comparable::NeverEquivalent, '#optimizable?' do
  subject { object.optimizable? }

  let(:described_class) { Class.new(Optimizer::Function::Predicate)      }
  let(:attribute)       { Attribute::Integer.new(:id, :size => 1..10)    }
  let(:predicate)       { Function::Predicate::Equality.new(left, right) }
  let(:object)          { described_class.new(predicate)                 }

  before do
    described_class.class_eval { include Optimizer::Function::Predicate::Comparable::NeverEquivalent }

    predicate.should be_kind_of(Function::Predicate::Comparable)
  end

  context 'when left is a constant and is valid' do
    let(:left)  { 1         }
    let(:right) { attribute }

    it { should be(false) }
  end

  context 'when left is a constand and is not valid' do
    let(:left)  { 0         }
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
    let(:right) { 0         }

    it { should be(true) }
  end

  context 'when left and right are joinable' do
    let(:left)  { attribute }
    let(:right) { attribute }

    it { should be(false) }
  end

  context 'when left and right are not joinable' do
    let(:left)  { attribute                                    }
    let(:right) { Attribute::Integer.new(:id, :size => -10..0) }

    it { should be(true) }
  end
end
