# encoding: utf-8

require 'spec_helper'

describe Optimizer::Relation::Operation::Sorted::UnoptimizedOperand, '#optimize' do
  subject { object.optimize }

  let(:base)     { Relation.new([[:id, Integer]], LazyEnumerable.new([[1]])) }
  let(:relation) { base.rename({}).sort_by { |r| r.id }                      }
  let(:object)   { described_class.new(relation)                             }

  before do
    expect(object).to be_optimizable
  end

  it { should be_kind_of(Relation::Operation::Sorted) }

  it { should_not be(relation) }

  its(:operand) { should be(base) }

  its(:directions) { should be(relation.directions) }
end
