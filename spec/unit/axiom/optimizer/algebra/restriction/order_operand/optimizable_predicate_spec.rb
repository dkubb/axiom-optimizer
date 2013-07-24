# encoding: utf-8

require 'spec_helper'

describe Optimizer::Algebra::Restriction::OrderOperand, '#optimizable?' do
  subject { object.optimizable? }

  let(:base)      { Relation.new([[:id, Integer]], LazyEnumerable.new([[1]])) }
  let(:predicate) { base[:id].eq(1)                                           }
  let(:relation)  { operand.restrict { predicate }                            }
  let(:object)    { described_class.new(relation)                             }

  before do
    expect(object.operation).to be_kind_of(Algebra::Restriction)
  end

  context 'when the operand is an order operation' do
    let(:operand) { base.sort_by { |r| r.id } }

    it { should be(true) }
  end

  context 'when the operand is not an order operation' do
    let(:operand) { base }

    it { should be(false) }
  end
end
