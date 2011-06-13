# encoding: utf-8

require 'spec_helper'

describe Optimizer::Relation::Operation::Offset::ZeroOffset, '#optimize' do
  subject { object.optimize }

  let(:order)    { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ].each).sort_by { |r| r[:id] } }
  let(:relation) { order.drop(0)                                                             }
  let(:object)   { described_class.new(relation)                                             }

  before do
    object.should be_optimizable
  end

  it { should equal(order) }
end
