require 'spec_helper'

describe Optimizer::Logic::Connective::Disjunction::Tautology, '#optimizable?' do
  subject { object.optimizable? }

  let(:attribute)  { Attribute::Integer.new(:id)                     }
  let(:connective) { Logic::Connective::Disjunction.new(left, right) }
  let(:object)     { described_class.new(connective)                 }

  before do
    object.operation.should be_kind_of(Logic::Connective::Disjunction)
  end

  context 'when left is a tautology' do
    let(:left)  { Logic::Proposition::Tautology.instance }
    let(:right) { attribute.eq(1)                        }

    it { should be(true) }
  end

  context 'when right is a tautology' do
    let(:left)  { attribute.eq(1)                        }
    let(:right) { Logic::Proposition::Tautology.instance }

    it { should be(true) }
  end

  context 'when left and right are inequality predicates with the same attribute and constant values' do
    let(:left)  { attribute.ne(1) }
    let(:right) { attribute.ne(2) }

    it { should be(true) }
  end

  context 'when left and right are inverses' do
    let(:left)  { attribute.eq(1) }
    let(:right) { attribute.ne(1) }

    it { should be(true) }
  end
end
