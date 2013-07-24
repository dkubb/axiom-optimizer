# encoding: utf-8

require 'spec_helper'

describe Optimizer::Function::Predicate::LessThan::Tautology, '#optimizable?' do
  subject { object.optimizable? }

  let(:predicate) { left.lt(right)                 }
  let(:object)    { described_class.new(predicate) }

  before do
    expect(predicate).to be_kind_of(Function::Predicate::LessThan)
  end

  context 'when left is always less than right' do
    let(:left)  { Attribute::Integer.new(:id, :size => 1..9)   }
    let(:right) { Attribute::Integer.new(:id, :size => 10..20) }

    it { should be(true) }
  end

  context 'when left is equivalent to the right' do
    let(:left)  { Attribute::Integer.new(:id) }
    let(:right) { Attribute::Integer.new(:id) }

    it { should be(false) }
  end
end
