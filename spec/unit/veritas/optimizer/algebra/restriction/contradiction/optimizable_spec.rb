require 'spec_helper'

describe Optimizer::Algebra::Restriction::Contradiction, '#optimizable?' do
  subject { object.optimizable? }

  let(:header)   { Relation::Header.new([ [ :id, Integer ] ]) }
  let(:base)     { Relation.new(header, [ [ 1 ] ].each)       }
  let(:relation) { base.restrict { predicate }                }
  let(:object)   { described_class.new(relation)              }

  before do
    object.operation.should be_kind_of(Algebra::Restriction)
  end

  context 'when the predicate is a contradiction' do
    let(:predicate) { Function::Proposition::Contradiction.instance }

    it { should be(true) }
  end

  context 'when the predicate is not a contradiction' do
    let(:predicate) { Function::Proposition::Tautology.instance }

    it { should be(false) }
  end
end
