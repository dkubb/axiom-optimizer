# encoding: utf-8

require 'spec_helper'

describe Optimizer::Algebra::Projection::UnionOperand, '#optimizable?' do
  subject { object.optimizable? }

  let(:header)   { Relation::Header.coerce([[:id, Integer], [:name, String]])      }
  let(:left)     { Relation.new(header, LazyEnumerable.new([[1, 'Dan Kubb', 35]])) }
  let(:right)    { Relation.new(header, LazyEnumerable.new([[2, 'Dan Kubb', 35]])) }
  let(:relation) { operand.project([:id])                                          }
  let(:object)   { described_class.new(relation)                                   }

  before do
    expect(object.operation).to be_kind_of(Algebra::Projection)
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
