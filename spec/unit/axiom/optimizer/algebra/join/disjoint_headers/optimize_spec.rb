# encoding: utf-8

require 'spec_helper'

describe Optimizer::Algebra::Join::DisjointHeaders, '#optimize' do
  subject { object.optimize }

  let(:left)     { Relation.new([[:id, Integer]], LazyEnumerable.new([[1]]))       }
  let(:right)    { Relation.new([[:other_id, Integer]], LazyEnumerable.new([[2]])) }
  let(:relation) { left.join(right)                                                }
  let(:object)   { described_class.new(relation)                                   }

  before do
    expect(object).to be_optimizable
  end

  it { should be_kind_of(Algebra::Product) }

  its(:left) { should be(left) }

  its(:right) { should be(right) }
end
