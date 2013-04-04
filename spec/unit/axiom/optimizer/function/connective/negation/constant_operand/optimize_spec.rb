# encoding: utf-8

require 'spec_helper'

describe Optimizer::Function::Connective::Negation::ConstantOperand, '#optimize' do
  subject { object.optimize }

  let(:negation) { Function::Connective::Negation.new(false) }
  let(:object)   { described_class.new(negation)             }

  before do
    object.should be_optimizable
  end

  it { should equal(Function::Proposition::Tautology.instance) }
end
