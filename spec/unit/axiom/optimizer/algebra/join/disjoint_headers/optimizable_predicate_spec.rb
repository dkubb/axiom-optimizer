# encoding: utf-8

require 'spec_helper'

describe Optimizer::Algebra::Join::DisjointHeaders, '#optimizable?' do
  subject { object.optimizable? }

  let(:relation) { left.join(right)              }
  let(:object)   { described_class.new(relation) }

  before do
    expect(object.operation).to be_kind_of(Algebra::Join)
  end

  context 'when left and right headers are disjoint' do
    let(:left)  { Relation.new([[:id, Integer]], LazyEnumerable.new([[1]]))       }
    let(:right) { Relation.new([[:other_id, Integer]], LazyEnumerable.new([[1]])) }

    it { should be(true) }
  end

  context 'when left and right headers are not disjoint' do
    let(:header) { [[:id, Integer]]                                }
    let(:left)   { Relation.new(header, LazyEnumerable.new([[1]])) }
    let(:right)  { Relation.new(header, LazyEnumerable.new([[1]])) }

    it { should be(false) }
  end
end
