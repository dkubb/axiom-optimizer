# encoding: utf-8

require 'spec_helper'

describe Optimizer::Algebra::Rename::ReverseOperand, '#optimizable?' do
  subject { object.optimizable? }

  let(:base)     { Relation.new([[:id, Integer]], LazyEnumerable.new([[1]])) }
  let(:relation) { operand.rename(id: :other_id)                             }
  let(:object)   { described_class.new(relation)                             }

  before do
    expect(object.operation).to be_kind_of(Algebra::Rename)
  end

  context 'when the operand is an reverse operation' do
    let(:operand) { base.sort_by { |r| r.id }.take(2).reverse }

    it { should be(true) }
  end

  context 'when the operand is not an reverse operation' do
    let(:operand) { base }

    it { should be(false) }
  end
end
