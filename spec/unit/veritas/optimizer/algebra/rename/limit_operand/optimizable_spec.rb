# encoding: utf-8

require 'spec_helper'

describe Optimizer::Algebra::Rename::LimitOperand, '#optimizable?' do
  subject { object.optimizable? }

  let(:base)     { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ].each) }
  let(:aliases)  { { :id => :other_id }                               }
  let(:relation) { operand.rename(aliases)                            }
  let(:object)   { described_class.new(relation)                      }

  before do
    object.operation.should be_kind_of(Algebra::Rename)
  end

  context 'when the operand is an limit operation' do
    let(:operand) { base.sort_by { |r| r[:id] }.take(1) }

    it { should be(true) }
  end

  context 'when the operand is not an limit operation' do
    let(:operand) { base }

    it { should be(false) }
  end
end
