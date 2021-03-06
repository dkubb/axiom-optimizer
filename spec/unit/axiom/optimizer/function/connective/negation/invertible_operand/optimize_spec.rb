# encoding: utf-8

require 'spec_helper'

describe Optimizer::Function::Connective::Negation::InvertibleOperand, '#optimize' do
  subject { object.optimize }

  let(:attribute) { Attribute::Integer.new(:id)                 }
  let(:operand)   { attribute.eq(1)                             }
  let(:negation)  { Function::Connective::Negation.new(operand) }
  let(:object)    { described_class.new(negation)               }

  before do
    expect(object).to be_optimizable
  end

  it { should be_kind_of(Function::Predicate::Inequality) }

  its(:left) { should be(attribute) }

  its(:right) { should == 1 }
end
