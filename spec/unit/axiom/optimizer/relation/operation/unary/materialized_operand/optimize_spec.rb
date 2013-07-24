# encoding: utf-8

require 'spec_helper'

describe Optimizer::Relation::Operation::Unary::MaterializedOperand, '#optimize' do
  subject { object.optimize }

  let(:relation) { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ]).project([ :id ]) }
  let(:object)   { described_class.new(relation)                                  }

  before do
    expect(object).to be_optimizable
  end

  it { should be_kind_of(Relation::Materialized) }

  its(:header) { should be(relation.header) }

  it { should == [ [ 1 ] ] }
end
