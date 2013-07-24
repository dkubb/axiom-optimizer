# encoding: utf-8

require 'spec_helper'

describe Optimizer::Relation::Operation::Reverse::ReverseOperand, '#optimize' do
  subject { object.optimize }

  let(:base)     { Relation.new([ [ :id, Integer ] ], LazyEnumerable.new([ [ 1 ] ])) }
  let(:limit)    { base.sort_by { |r| r.id }.take(2)                                 }
  let(:operand)  { limit.reverse                                                     }
  let(:relation) { operand.reverse                                                   }
  let(:object)   { described_class.new(relation)                                     }

  before do
    expect(object).to be_optimizable
  end

  it { should be(limit) }
end
