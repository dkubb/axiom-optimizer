# encoding: utf-8

require 'spec_helper'

describe Optimizer::Function::Predicate::ConstantOperands, '#optimize' do
  subject { object.optimize }

  let(:predicate) { Function::Predicate::Equality.new(1, 1) }
  let(:object)    { described_class.new(predicate)          }

  before do
    expect(object).to be_optimizable
  end

  it { should be(Function::Proposition::Tautology.instance) }
end
