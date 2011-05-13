require 'spec_helper'

describe Optimizer::Function::Connective::Disjunction::OptimizableToInclusion, '#optimizable?' do
  subject { object.optimizable? }

  let(:attribute)  { Attribute::Integer.new(:id)     }
  let(:connective) { left.or(right)                  }
  let(:object)     { described_class.new(connective) }

  before do
    object.operation.should be_kind_of(Function::Connective::Disjunction)
  end

  context 'when the operands are optimizable' do
    let(:left)  { attribute.eq(2) }
    let(:right) { attribute.eq(1) }

    it { should be(true) }
  end

  context 'when the operands are not optimizable' do
    let(:left)  { attribute.ne(1) }
    let(:right) { attribute.eq(2) }

    it { should be(false) }
  end
end
