# encoding: utf-8

require 'spec_helper'

describe Optimizer::Algebra::Summarization::OrderOperand, '#optimize' do
  subject { object.optimize }

  let(:base)     { Relation.new([ [ :id, Integer ] ], LazyEnumerable.new) }
  let(:operand)  { base.sort_by { |r| r.id }                              }
  let(:relation) { operand.summarize([]) {}                               }
  let(:object)   { described_class.new(relation)                          }

  before do
    expect(object).to be_optimizable
  end

  it { should be_kind_of(Algebra::Summarization) }

  its(:operand) { should be(base) }

  its(:summarizers) { should eql(relation.summarizers) }
end
