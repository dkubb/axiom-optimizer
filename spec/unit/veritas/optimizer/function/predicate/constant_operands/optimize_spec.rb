require 'spec_helper'

describe Optimizer::Function::Predicate::ConstantOperands, '#optimize' do
  subject { object.optimize }

  let(:predicate) { Function::Predicate::Equality.new(1, 1) }
  let(:object)    { described_class.new(predicate)          }

  before do
    object.should be_optimizable
  end

  it { should equal(Function::Proposition::Tautology.instance) }
end
