# encoding: utf-8

require 'spec_helper'

describe Optimizer::Algebra::Restriction::SetOperand, '#optimizable?' do
  subject { object.optimizable? }

  let(:header)    { Relation::Header.coerce([ [ :id, Integer ] ])       }
  let(:left)      { Relation.new(header, LazyEnumerable.new([ [ 1 ] ])) }
  let(:right)     { Relation.new(header, LazyEnumerable.new([ [ 2 ] ])) }
  let(:predicate) { header[:id].eq(1)                                   }
  let(:relation)  { operand.restrict { predicate }                      }
  let(:object)    { described_class.new(relation)                       }

  before do
    object.operation.should be_kind_of(Algebra::Restriction)
  end

  context 'when the operand is a set operation' do
    let(:operand) { left.union(right) }

    it { should be(true) }
  end

  context 'when the operand is not a set operation' do
    let(:operand) { left }

    it { should be(false) }
  end
end
