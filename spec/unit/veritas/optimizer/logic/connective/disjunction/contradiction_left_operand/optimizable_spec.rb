require 'spec_helper'

describe Optimizer::Logic::Connective::Disjunction::ContradictionLeftOperand, '#optimizable?' do
  subject { object.optimizable? }

  let(:attribute)  { Attribute::Integer.new(:id)                     }
  let(:connective) { Logic::Connective::Disjunction.new(left, right) }
  let(:object)     { described_class.new(connective)                 }

  before do
    object.operation.should be_kind_of(Logic::Connective::Disjunction)
  end

  context 'when right is a tautology' do
    let(:left)  { Logic::Proposition::Contradiction.instance }
    let(:right) { attribute.eq(1)                            }

    it { should be(true) }
  end

  context 'when right is not a tautology' do
    let(:left)  { attribute.eq(1) }
    let(:right) { attribute.eq(1) }

    it { should be(false) }
  end
end
