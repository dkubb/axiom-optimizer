# encoding: utf-8

require 'spec_helper'

describe Optimizer::Algebra::Join::DisjointHeaders, '#optimize' do
  subject { object.optimize }

  let(:left)     { Relation.new([ [ :id,       Integer ] ], [ [ 1 ] ].each) }
  let(:right)    { Relation.new([ [ :other_id, Integer ] ], [ [ 2 ] ].each) }
  let(:relation) { left.join(right)                                         }
  let(:object)   { described_class.new(relation)                            }

  before do
    object.should be_optimizable
  end

  it { should be_kind_of(Algebra::Product) }

  its(:left) { should equal(left) }

  its(:right) { should equal(right) }
end
