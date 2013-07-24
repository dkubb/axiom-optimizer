# encoding: utf-8

require 'spec_helper'

describe Optimizer::Algebra::Projection::UnionOperand, '#optimize' do
  subject { object.optimize }

  let(:header)     { Relation::Header.coerce([[:id, Integer], [:name, String], [:age, Integer]]) }
  let(:base_left)  { Relation.new(header, LazyEnumerable.new([[1, 'Dan Kubb', 35]]))             }
  let(:base_right) { Relation.new(header, LazyEnumerable.new([[2, 'Dan Kubb', 35]]))             }
  let(:left)       { base_left.rename({})                                                        }
  let(:right)      { base_right.rename({})                                                       }
  let(:relation)   { left.union(right).project([:id])                                            }
  let(:object)     { described_class.new(relation)                                               }

  before do
    expect(object).to be_optimizable
  end

  it { should be_kind_of(Algebra::Union) }

  its(:left) { should eql(base_left.project([:id])) }

  its(:right) { should eql(base_right.project([:id])) }
end
