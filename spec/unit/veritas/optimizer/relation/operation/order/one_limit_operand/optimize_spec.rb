# encoding: utf-8

require 'spec_helper'

describe Optimizer::Relation::Operation::Order::OneLimitOperand, '#optimize' do
  subject { object.optimize }

  let(:base)     { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ].each) }
  let(:limit)    { base.sort_by { |r| r[:id] }.take(1)                }
  let(:relation) { limit.sort_by { |r| r[:id] }                       }
  let(:object)   { described_class.new(relation)                      }

  before do
    object.should be_optimizable
  end

  it { should equal(limit) }
end
