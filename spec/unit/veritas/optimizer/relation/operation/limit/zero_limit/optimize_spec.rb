# encoding: utf-8

require 'spec_helper'

describe Optimizer::Relation::Operation::Limit::ZeroLimit, '#optimize' do
  subject { object.optimize }

  let(:header)   { Relation::Header.new([ [ :id, Integer ] ])                }
  let(:order)    { Relation.new(header, [ [ 1 ] ].each).sort_by { |r| r.id } }
  let(:relation) { order.take(0)                                             }
  let(:object)   { described_class.new(relation)                             }

  before do
    object.should be_optimizable
  end

  it { should be_kind_of(Relation::Empty) }

  its(:header) { should equal(header) }
end
