# encoding: utf-8

require 'spec_helper'

describe Optimizer::Algebra::Projection::UnoptimizedOperand, '#optimize' do
  subject { object.optimize }

  let(:header)   { Relation::Header.coerce([ [ :id, Integer ], [ :name, String ] ])             }
  let(:base)     { Relation.new(header, LazyEnumerable.new([ [ 1, 'Dan Kubb' ] ]))              }
  let(:relation) { base.restrict { Function::Proposition::Tautology.instance }.project([ :id ]) }
  let(:object)   { described_class.new(relation)                                                }

  before do
    expect(object).to be_optimizable
  end

  it { should be_kind_of(Algebra::Projection) }

  its(:operand) { should be(base) }

  its(:header) { should == [ header[:id] ] }
end
