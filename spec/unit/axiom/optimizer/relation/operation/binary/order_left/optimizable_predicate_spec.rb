# encoding: utf-8

require 'spec_helper'

describe Optimizer::Relation::Operation::Binary::OrderLeft, '#optimizable?' do
  subject { object.optimizable? }

  let(:relation) { double('Relation', :left => left, :right => right) }
  let(:right)    { double('Right')                                    }
  let(:object)   { described_class.new(relation)                      }

  context 'when left is an order' do
    let(:left) { Relation.new([ [ :id, Integer ] ], LazyEnumerable.new).sort_by { |r| r.id } }

    it { should be(true) }
  end

  context 'when left is not an order' do
    let(:left) { Relation.new([ [ :id, Integer ] ], LazyEnumerable.new) }

    it { should be(false) }
  end
end
