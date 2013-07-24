# encoding: utf-8

require 'spec_helper'

describe Optimizer::Relation::Operation::Limit::LimitOperand, '#optimize' do
  subject { object.optimize }

  let(:order)  { Relation.new([[:id, Integer]], LazyEnumerable.new([[1]])).sort_by { |r| r.id } }
  let(:limit)  { order.take(2)                                                                  }
  let(:object) { described_class.new(relation)                                                  }

  before do
    expect(object).to be_optimizable
  end

  context 'when the operand has a larger limit than the operation' do
    let(:relation) { limit.take(1) }

    it { should be_kind_of(Relation::Operation::Limit) }

    its(:operand) { should be(order) }

    its(:limit) { should == 1 }
  end

  context 'when the operand has a smaller limit than the operation' do
    let(:relation) { limit.take(3) }

    it { should be_kind_of(Relation::Operation::Limit) }

    its(:operand) { should be(order) }

    its(:limit) { should == 2 }
  end
end
