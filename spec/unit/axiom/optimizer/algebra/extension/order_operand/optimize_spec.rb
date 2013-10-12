# encoding: utf-8

require 'spec_helper'

describe Optimizer::Algebra::Extension::OrderOperand, '#optimize' do
  subject { object.optimize }

  let(:base)     { Relation.new([[:id, Integer]], LazyEnumerable.new) }
  let(:operand)  { base.sort_by { |r| r.id }                          }
  let(:relation) { operand.extend { }                                 }
  let(:object)   { described_class.new(relation)                      }

  before do
    expect(object).to be_optimizable
  end

  it { should be_kind_of(Algebra::Extension) }

  its(:operand) { should be(base) }

  its(:extensions) { should eql(relation.extensions) }
end
