# encoding: utf-8

require 'spec_helper'

describe Optimizer::Algebra::Rename::UnoptimizedOperand, '#optimizable?' do
  subject { object.optimizable? }

  let(:header)   { Relation::Header.coerce([ [ :id, Integer ] ])       }
  let(:base)     { Relation.new(header, LazyEnumerable.new([ [ 1 ] ])) }
  let(:relation) { operand.rename(aliases)                             }
  let(:aliases)  { { :id => :other_id }                                }
  let(:object)   { described_class.new(relation)                       }

  before do
    object.operation.should be_kind_of(Algebra::Rename)
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
