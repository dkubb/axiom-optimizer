# encoding: utf-8

require 'spec_helper'

describe Optimizer::Relation::Operation::Unary::EmptyOperand, '#optimize' do
  subject { object.optimize }

  let(:operand)  { Relation::Empty.new([[:id, Integer]]) }
  let(:relation) { operand.rename({})                    }
  let(:object)   { described_class.new(relation)         }

  before do
    expect(object).to be_optimizable
  end

  it { should be(operand) }
end
