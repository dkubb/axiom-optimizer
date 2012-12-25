# encoding: utf-8

require 'spec_helper'

describe Optimizer::Algebra::Rename::RestrictionOperand, '#optimizable?' do
  subject { object.optimizable? }

  let(:header)    { Relation::Header.coerce([ [ :id, Integer ] ]) }
  let(:base)      { Relation.new(header, [ [ 1 ] ].each)          }
  let(:predicate) { base[:id].eq(1)                               }
  let(:relation)  { operand.rename(:id => :other_id)              }
  let(:object)    { described_class.new(relation)                 }

  before do
    object.operation.should be_kind_of(Algebra::Rename)
  end

  context 'when the operand is a restriction' do
    let(:operand) { base.restrict { predicate } }

    it { should be(true) }
  end

  context 'when the operand is not a restriction' do
    let(:operand) { base }

    it { should be(false) }
  end
end
