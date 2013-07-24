# encoding: utf-8

require 'spec_helper'

describe Optimizer::Algebra::Rename::UnoptimizedOperand, '#optimize' do
  subject { object.optimize }

  let(:base)     { Relation.new([[:id, Integer]], LazyEnumerable.new([[1]])) }
  let(:relation) { base.rename({}).rename(id: :other_id)                     }
  let(:object)   { described_class.new(relation)                             }

  before do
    expect(object).to be_optimizable
  end

  it { should be_kind_of(Algebra::Rename) }

  it { should_not be(relation) }

  its(:operand) { should be(base) }

  its(:aliases) { should be(relation.aliases) }
end
