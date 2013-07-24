# encoding: utf-8

require 'spec_helper'

describe Optimizer::Relation::Operation::Order::UnoptimizedOperand, '#optimizable?' do
  subject { object.optimizable? }

  let(:header)   { Relation::Header.coerce([ [ :id, Integer ] ])       }
  let(:base)     { Relation.new(header, LazyEnumerable.new([ [ 1 ] ])) }
  let(:relation) { operand.sort_by { |r| r.id }                        }
  let(:object)   { described_class.new(relation)                       }

  before do
    expect(object.operation).to be_kind_of(Relation::Operation::Order)
  end

  context 'when the operand is optimizable' do
    let(:operand) { base.rename({}) }

    it { should be(true) }
  end

  context 'when the operand is not optimizable' do
    let(:operand) { base }

    it { should be(false) }
  end
end
