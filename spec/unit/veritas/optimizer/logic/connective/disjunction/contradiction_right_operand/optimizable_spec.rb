require 'spec_helper'

describe Optimizer::Logic::Connective::Disjunction::ContradictionRightOperand, '#optimizable?' do
  subject { object.optimizable? }

  let(:attribute)  { Attribute::Integer.new(:id)     }
  let(:connective) { left.or(right)                  }
  let(:object)     { described_class.new(connective) }

  before do
    object.operation.should be_kind_of(Logic::Connective::Disjunction)
  end

  context 'when right is a contradiction' do
    let(:left)  { attribute.eq(1)                            }
    let(:right) { Logic::Proposition::Contradiction.instance }

    it { should be(true) }
  end

  context 'when right is not a contradiction' do
    let(:left)  { attribute.eq(1) }
    let(:right) { attribute.eq(1) }

    it { should be(false) }
  end
end
