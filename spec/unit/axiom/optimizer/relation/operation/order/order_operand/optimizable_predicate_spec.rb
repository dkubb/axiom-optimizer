# encoding: utf-8

require 'spec_helper'

describe Optimizer::Relation::Operation::Order::OrderOperand, '#optimizable?' do
  subject { object.optimizable? }

  let(:base)     { Relation.new([[:id, Integer]], LazyEnumerable.new([[1]])) }
  let(:relation) { operand.sort_by { |r| r.id }                              }
  let(:object)   { described_class.new(relation)                             }

  before do
    expect(object.operation).to be_kind_of(Relation::Operation::Order)
  end

  context 'when the operand is ordered' do
    let(:operand) { base.sort_by { |r| r.id } }

    it { should be(true) }
  end

  context 'when the operand is not ordered' do
    let(:operand) { base }

    it { should be(false) }
  end
end
