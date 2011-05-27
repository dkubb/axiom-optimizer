# encoding: utf-8

require 'spec_helper'

describe Optimizer::Function::Connective::Binary::ConstantOperands, '#optimize' do
  subject { object.optimize }

  let(:connective) { Function::Connective::Conjunction.new(true, true) }
  let(:object)     { described_class.new(connective)                   }

  before do
    object.should be_optimizable
  end

  it { should equal(Function::Proposition::Tautology.instance) }
end
