# encoding: utf-8

require 'spec_helper'

describe Optimizer::Relation::Operation::Limit::EqualLimitOperand, '#optimizable?' do
  subject { object.optimizable? }

  let(:base)     { Relation.new([[:id, Integer]], LazyEnumerable.new([[1]])).sort_by { |r| r.id } }
  let(:relation) { operand.take(1)                                                                }
  let(:object)   { described_class.new(relation)                                                  }

  before do
    expect(object.operation).to be_kind_of(Relation::Operation::Limit)
  end

  context 'when the operand is limited and not equal to the operation' do
    let(:operand) { base.take(2) }

    it { should be(false) }
  end

  context 'when the operand is limited and equal to the operation' do
    let(:operand) { base.take(1) }

    it { should be(true) }
  end

  context 'when the operand is not limited' do
    let(:operand) { base }

    it { should be(false) }
  end
end
