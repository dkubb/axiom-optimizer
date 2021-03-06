# encoding: utf-8

require 'spec_helper'

describe Optimizer::Function::Predicate::Equality::Tautology, '#optimizable?' do
  subject { object.optimizable? }

  let(:attribute) { Attribute::Integer.new(:id)    }
  let(:predicate) { left.eq(right)                 }
  let(:object)    { described_class.new(predicate) }

  before do
    expect(predicate).to be_kind_of(Function::Predicate::Equality)
  end

  context 'when left and right are equal' do
    let(:left)  { attribute }
    let(:right) { attribute }

    it { should be(true) }
  end

  context 'when left and right are not equal' do
    let(:left)  { attribute }
    let(:right) { 1         }

    it { should be(false) }
  end
end
