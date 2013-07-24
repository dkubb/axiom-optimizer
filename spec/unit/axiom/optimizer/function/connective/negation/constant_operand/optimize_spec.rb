# encoding: utf-8

require 'spec_helper'

describe Optimizer::Function::Connective::Negation::ConstantOperand, '#optimize' do
  subject { object.optimize }

  let(:negation) { Function::Connective::Negation.new(false) }
  let(:object)   { described_class.new(negation)             }

  before do
    expect(object).to be_optimizable
  end

  it { should be(Function::Proposition::Tautology.instance) }
end
