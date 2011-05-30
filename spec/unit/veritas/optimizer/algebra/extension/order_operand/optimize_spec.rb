# encoding: utf-8

require 'spec_helper'

describe Optimizer::Algebra::Extension::OrderOperand, '#optimize' do
  subject { object.optimize }

  let(:base)     { Relation.new([ [ :id, Integer ] ], [].each) }
  let(:operand)  { base.order                                  }
  let(:relation) { operand.extend {}                           }
  let(:object)   { described_class.new(relation)               }

  before do
    object.should be_optimizable
  end

  it { should be_kind_of(Algebra::Extension) }

  its(:operand) { should equal(base) }

  its(:extensions) { should eql(relation.extensions) }
end
