# encoding: utf-8

require 'spec_helper'

describe Optimizer::Relation::Operation::Binary::OrderRight, '#optimizable?' do
  subject { object.optimizable? }

  let(:relation) { mock('Relation', :left => left, :right => right) }
  let(:left)     { mock('Left')                                     }
  let(:object)   { described_class.new(relation)                    }

  context 'when right is an order' do
    let(:right) { Relation.new([ [ :id, Integer ] ], [].each).sort_by { |r| r.id } }

    it { should be(true) }
  end

  context 'when right is not an order' do
    let(:right) { Relation.new([ [ :id, Integer ] ], [].each) }

    it { should be(false) }
  end
end
