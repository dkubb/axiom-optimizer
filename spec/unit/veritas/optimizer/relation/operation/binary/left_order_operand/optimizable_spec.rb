# encoding: utf-8

require 'spec_helper'

describe Optimizer::Relation::Operation::Binary::LeftOrderOperand, '#optimizable?' do
  subject { object.optimizable? }

  let(:relation) { mock('Relation', :left => left, :right => right) }
  let(:right)    { mock('Right')                                    }
  let(:object)   { described_class.new(relation)                    }

  context 'when left is an order' do
    let(:left) { Relation.new([ [ :id, Integer ] ], [].each).order }

    it { should be(true) }
  end

  context 'when left is not an order' do
    let(:left) { Relation.new([ [ :id, Integer ] ], [].each) }

    it { should be(false) }
  end
end
