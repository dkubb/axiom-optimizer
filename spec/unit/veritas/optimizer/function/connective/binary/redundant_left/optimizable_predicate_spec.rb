# encoding: utf-8

require 'spec_helper'

describe Optimizer::Function::Connective::Binary::RedundantLeft, '#optimizable?' do
  subject { object.optimizable? }

  let(:attribute)  { Attribute::Integer.new(:id)     }
  let(:left)       { attribute.include([ 1 ])        }
  let(:right)      { attribute.exclude([ 2 ])        }
  let(:object)     { described_class.new(connective) }

  before do
    object.operation.should be_kind_of(Function::Connective::Binary)
  end

  context 'when the left operand is redundant' do
    let(:connective) { left.and(right).and(right) }

    it { should be(true) }
  end

  context 'when the left operand is not redundant' do
    let(:connective) { left.and(right) }

    it { should be(false) }
  end
end
