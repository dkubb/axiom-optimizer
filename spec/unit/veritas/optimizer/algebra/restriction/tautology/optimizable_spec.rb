# encoding: utf-8

require 'spec_helper'

describe Optimizer::Algebra::Restriction::Tautology, '#optimizable?' do
  subject { object.optimizable? }

  let(:base)     { Relation.new([ [ :id, Integer ] ], LazyEnumerable.new([ [ 1 ] ])) }
  let(:relation) { base.restrict { predicate }                                       }
  let(:object)   { described_class.new(relation)                                     }

  before do
    object.operation.should be_kind_of(Algebra::Restriction)
  end

  context 'when the predicate is a tautology' do
    let(:predicate) { Function::Proposition::Tautology.instance }

    it { should be(true) }
  end

  context 'when the predicate is not a tautology' do
    let(:predicate) { Function::Proposition::Contradiction.instance }

    it { should be(false) }
  end

  context 'when the predicate is true' do
    let(:predicate) { true }

    it { should be(true) }
  end
end
