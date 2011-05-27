# encoding: utf-8

require 'spec_helper'

describe Optimizer::Function::Binary, '#right' do
  subject { object.right }

  let(:described_class) { Class.new(Optimizer) { include Optimizer::Function::Binary }                        }
  let(:left)            { 'Left'                                                                              }
  let(:function)        { Class.new(Veritas::Function) { include Veritas::Function::Binary }.new(left, right) }
  let(:object)          { described_class.new(function)                                                       }

  context 'when right operand is frozen' do
    let(:right) { 'Right'.freeze }

    it { should equal(right) }
  end

  context 'when right operand is not frozen' do
    let(:right) { 'Right' }

    it { should_not equal(right) }

    it { should be_frozen }

    it { should == right }
  end
end
