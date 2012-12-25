# encoding: utf-8

require 'spec_helper'

describe Optimizer::Algebra::Rename::SetOperand, '#optimizable?' do
  subject { object.optimizable? }

  let(:header)   { Relation::Header.coerce([ [ :id, Integer ] ]) }
  let(:left)     { Relation.new(header, [ [ 1 ] ].each)          }
  let(:right)    { Relation.new(header, [ [ 2 ] ].each)          }
  let(:relation) { operand.rename(:id => :other_id)              }
  let(:object)   { described_class.new(relation)                 }

  before do
    object.operation.should be_kind_of(Algebra::Rename)
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
