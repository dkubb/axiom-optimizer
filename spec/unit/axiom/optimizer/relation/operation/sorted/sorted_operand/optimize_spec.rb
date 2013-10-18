# encoding: utf-8

require 'spec_helper'

describe Optimizer::Relation::Operation::Sorted::SortedOperand, '#optimize' do
  subject { object.optimize }

  let(:base)     { Relation.new([[:id, Integer]], LazyEnumerable.new([[1]])) }
  let(:sorted)   { base.sort_by { |r| r.id }                                 }
  let(:relation) { sorted.sort_by { sorted.directions.reverse }              }
  let(:object)   { described_class.new(relation)                             }

  before do
    expect(object).to be_optimizable
  end

  it { should be_kind_of(Relation::Operation::Sorted) }

  its(:operand) { should be(base) }

  its(:directions) { should eql(sorted.directions.reverse) }
end
