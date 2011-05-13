require 'spec_helper'

describe Optimizer::Function::Predicate::GreaterThan::Tautology, '#optimizable?' do
  subject { object.optimizable? }

  let(:predicate) { left.gt(right)                 }
  let(:object)    { described_class.new(predicate) }

  before do
    predicate.should be_kind_of(Function::Predicate::GreaterThan)
  end

  context 'when left is always greater than right' do
    let(:left)  { Attribute::Integer.new(:id, :size => 10..20) }
    let(:right) { Attribute::Integer.new(:id, :size => 1..9)   }

    it { should be(true) }
  end

  context 'when left is equivalent to the right' do
    let(:left)  { Attribute::Integer.new(:id) }
    let(:right) { Attribute::Integer.new(:id) }

    it { should be(false) }
  end
end
