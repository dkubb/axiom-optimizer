# encoding: utf-8

require 'spec_helper'

describe Optimizer::Relation::Operation::Offset::OffsetOperand, '#optimize' do
  subject { object.optimize }

  let(:sorted)   { Relation.new([[:id, Integer]], LazyEnumerable.new([[1]])).sort_by { |r| r.id } }
  let(:relation) { sorted.drop(1).drop(2)                                                         }
  let(:object)   { described_class.new(relation)                                                  }

  before do
    expect(object).to be_optimizable
  end

  it { should be_kind_of(Relation::Operation::Offset) }

  its(:operand) { should be(sorted) }

  its(:offset) { should == 3 }
end
