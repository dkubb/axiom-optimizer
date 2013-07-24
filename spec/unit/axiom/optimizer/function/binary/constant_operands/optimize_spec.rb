# encoding: utf-8

require 'spec_helper'

describe Optimizer::Function::Binary::ConstantOperands, '#optimize' do
  subject { object.optimize }

  let(:described_class) { Class.new(Optimizer) { include Optimizer::Function::Binary } }
  let(:function)        { Function::Numeric::Addition.new(2, 2)                        }
  let(:object)          { described_class.new(function)                                }

  before do
    described_class.class_eval { include Optimizer::Function::Binary::ConstantOperands }
    expect(object).to be_optimizable
  end

  it { should be(4) }
end
