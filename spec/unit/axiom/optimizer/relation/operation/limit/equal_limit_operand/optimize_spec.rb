# encoding: utf-8

require 'spec_helper'

describe Optimizer::Relation::Operation::Limit::EqualLimitOperand, '#optimize' do
  subject { object.optimize }

  let(:order)    { Relation.new([ [ :id, Integer ] ], LazyEnumerable.new([ [ 1 ] ])).sort_by { |r| r.id } }
  let(:limit)    { order.take(1)                                                                          }
  let(:relation) { limit.take(1)                                                                          }
  let(:object)   { described_class.new(relation)                                                          }

  before do
    expect(object).to be_optimizable
  end

  it { should be(limit) }
end
