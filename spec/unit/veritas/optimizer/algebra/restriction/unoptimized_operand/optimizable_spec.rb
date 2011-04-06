require 'spec_helper'

describe Optimizer::Algebra::Restriction::UnoptimizedOperand, '#optimizable?' do
  subject { object.optimizable? }

  let(:header)   { Relation::Header.new([ [ :id, Integer ] ]) }
  let(:base)     { Relation.new(header, [ [ 1 ] ].each)       }
  let(:relation) { operand.restrict(predicate)                }
  let(:object)   { described_class.new(relation)              }

  before do
    object.operation.should be_kind_of(Algebra::Restriction)
  end

  context 'when the operand and predicate is optimizable' do
    let(:predicate) { Logic::Connective::Negation.new(header[:id].eq(1)) }
    let(:operand)   { base.rename({})                                    }

    it { should be(true) }
  end

  context 'when the operand is optimizable, but the predicate is not optimizable' do
    let(:predicate) { header[:id].eq(1) }
    let(:operand)   { base.rename({})   }

    it { should be(true) }
  end

  context 'when the operand is not optimizable, but the predicate is optimizable' do
    let(:predicate) { Logic::Connective::Negation.new(header[:id].eq(1)) }
    let(:operand)   { base                                               }

    it { should be(true) }
  end

  context 'when the operand and predicate are not optimizable' do
    let(:predicate) { header[:id].eq(1) }
    let(:operand)   { base              }

    it { should be(false) }
  end
end
