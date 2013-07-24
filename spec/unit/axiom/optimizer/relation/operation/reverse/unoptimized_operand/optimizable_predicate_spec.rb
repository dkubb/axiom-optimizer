# encoding: utf-8

require 'spec_helper'

describe Optimizer::Relation::Operation::Reverse::UnoptimizedOperand, '#optimizable?' do
  subject { object.optimizable? }

  let(:base)     { Relation.new([[:id, Integer]], LazyEnumerable.new([[1]])).sort_by { |r| r.id } }
  let(:relation) { operand.reverse                                                                }
  let(:object)   { described_class.new(relation)                                                  }

  before do
    expect(object.operation).to be_kind_of(Relation::Operation::Reverse)
  end

  context 'when the operand is optimizable' do
    let(:operand) { base.reverse }

    it { should be(true) }
  end

  context 'when the operand is not optimizable' do
    let(:operand) { base }

    it { should be(false) }
  end
end
