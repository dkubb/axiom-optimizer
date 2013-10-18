# encoding: utf-8

require 'spec_helper'

describe Optimizer::Algebra::Summarization::SortedOperand, '#optimizable?' do
  subject { object.optimizable? }

  let(:base)     { Relation.new([[:id, Integer]], LazyEnumerable.new) }
  let(:relation) { operand.summarize([]) { }                          }
  let(:object)   { described_class.new(relation)                      }

  context 'when operand is sorted' do
    let(:operand) { base.sort_by { |r| r.id } }

    it { should be(true) }
  end

  context 'when operand is not sorted' do
    let(:operand) { base }

    it { should be(false) }
  end
end
