# encoding: utf-8

require 'spec_helper'

describe Optimizer::Algebra::Restriction::Contradiction, '#optimizable?' do
  subject { object.optimizable? }

  let(:header)   { Relation::Header.coerce([[:id, Integer]])       }
  let(:base)     { Relation.new(header, LazyEnumerable.new([[1]])) }
  let(:relation) { base.restrict { predicate }                     }
  let(:object)   { described_class.new(relation)                   }

  before do
    expect(object.operation).to be_kind_of(Algebra::Restriction)
  end

  context 'when the predicate is a contradiction' do
    let(:predicate) { Function::Proposition::Contradiction.instance }

    it { should be(true) }
  end

  context 'when the predicate is not a contradiction' do
    let(:predicate) { Function::Proposition::Tautology.instance }

    it { should be(false) }
  end

  context 'when the predicate is false' do
    let(:predicate) { false }

    it { should be(true) }
  end

  context 'when the predicate is true' do
    let(:predicate) { true }

    it { should be(false) }
  end

  context 'when the predicate is a Proc' do
    let(:predicate) { proc { false } }

    it { should be(false) }
  end
end
