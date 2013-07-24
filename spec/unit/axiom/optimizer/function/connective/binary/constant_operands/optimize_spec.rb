# encoding: utf-8

require 'spec_helper'

describe Optimizer::Function::Connective::Binary::ConstantOperands, '#optimize' do
  subject { object.optimize }

  let(:connective) { Function::Connective::Conjunction.new(true, true) }
  let(:object)     { described_class.new(connective)                   }

  before do
    expect(object).to be_optimizable
  end

  it { should be(Function::Proposition::Tautology.instance) }
end
