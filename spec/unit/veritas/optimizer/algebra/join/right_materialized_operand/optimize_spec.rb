# encoding: utf-8

require 'spec_helper'

describe Optimizer::Algebra::Join::RightMaterializedOperand, '#optimize' do
  subject { object.optimize }

  let(:left)     { Relation.new([ [ :id, Integer ], [ :name, String  ]                     ], [ [ 1, 'Dan Kubb'     ] ].each) }
  let(:right)    { Relation.new([ [ :id, Integer ], [ :name, String, ], [ :age,  Integer ] ], [ [ 1, 'Dan Kubb', 35 ] ])      }
  let(:relation) { left.join(right)                                                                                           }
  let(:object)   { described_class.new(relation)                                                                              }

  before do
    object.should be_optimizable
  end

  it { should be_kind_of(Algebra::Join) }

  its(:left) { should eql(left.restrict { |r| r[:id].eq(1).and(r[:name].eq('Dan Kubb')) }) }

  its(:right) { should equal(right) }
end
