# encoding: utf-8

require 'spec_helper'

describe Optimizer::Algebra::Rename::SortedOperand, '#optimize' do
  subject { object.optimize }

  let(:base)     { Relation.new([[:id, Integer]], LazyEnumerable.new([[1]])) }
  let(:operand)  { base.sort_by { |r| r.id }                                 }
  let(:relation) { operand.rename(id: :other_id)                             }
  let(:object)   { described_class.new(relation)                             }

  before do
    expect(object).to be_optimizable
  end

  it { should be_kind_of(Relation::Operation::Sorted) }

  its(:operand) { should eql(base.rename(id: :other_id)) }

  its(:directions) { should == [relation[:other_id].asc] }
end
