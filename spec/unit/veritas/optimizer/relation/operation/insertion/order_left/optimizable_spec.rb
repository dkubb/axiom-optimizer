# encoding: utf-8

require 'spec_helper'

describe Optimizer::Relation::Operation::Insertion::OrderLeft, '#optimizable?' do
  subject { object.optimizable? }

  let(:object)    { described_class.new(relation)              }
  let(:relation)  { left.insert(right)                         }
  let(:base_left) { Relation.new(header, [ [ 1 ] ].each)       }
  let(:right)     { Relation.new(header, [ [ 2 ] ].each)       }
  let(:header)    { Relation::Header.new([ [ :id, Integer ] ]) }

  before do
    object.operation.should be_kind_of(Relation::Operation::Insertion)
  end

  context 'when the left is an order' do
    let(:left) { base_left.sort_by { header } }

    it { should be(true) }
  end

  context 'when the left is not an order' do
    let(:left) { base_left }

    it { should be(false) }
  end
end
