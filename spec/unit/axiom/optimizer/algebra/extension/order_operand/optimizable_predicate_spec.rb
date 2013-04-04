# encoding: utf-8

require 'spec_helper'

describe Optimizer::Algebra::Extension::OrderOperand, '#optimizable?' do
  subject { object.optimizable? }

  let(:base)     { Relation.new([ [ :id, Integer ] ], LazyEnumerable.new) }
  let(:relation) { operand.extend {}                                      }
  let(:object)   { described_class.new(relation)                          }

  context 'when operand is an order' do
    let(:operand) { base.sort_by { |r| r.id } }

    it { should be(true) }
  end

  context 'when operand is not an order' do
    let(:operand) { base }

    it { should be(false) }
  end
end
