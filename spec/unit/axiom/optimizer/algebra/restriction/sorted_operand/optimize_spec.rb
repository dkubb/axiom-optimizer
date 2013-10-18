# encoding: utf-8

require 'spec_helper'

describe Optimizer::Algebra::Restriction::SortedOperand, '#optimize' do
  subject { object.optimize }

  let(:base)      { Relation.new([[:id, Integer]], LazyEnumerable.new([[1]])) }
  let(:predicate) { base[:id].eq(1)                                           }
  let(:relation)  { base.sort_by { |r| r.id }.restrict { predicate }          }
  let(:object)    { described_class.new(relation)                             }

  before do
    expect(object).to be_optimizable
  end

  it { should be_kind_of(Algebra::Restriction) }

  its(:operand) { should be(base) }

  its(:predicate) { should be(predicate) }
end
