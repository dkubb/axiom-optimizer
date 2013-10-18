# encoding: utf-8

require 'spec_helper'

describe Optimizer::Relation::Operation::Binary::SortedRight, '#optimizable?' do
  subject { object.optimizable? }

  let(:relation) { double('Relation', left: left, right: right) }
  let(:left)     { double('Left')                               }
  let(:object)   { described_class.new(relation)                }

  context 'when right is sorted' do
    let(:right) { Relation.new([[:id, Integer]], LazyEnumerable.new).sort_by { |r| r.id } }

    it { should be(true) }
  end

  context 'when right is not sorted' do
    let(:right) { Relation.new([[:id, Integer]], LazyEnumerable.new) }

    it { should be(false) }
  end
end
