# encoding: utf-8

require 'spec_helper'

describe Optimizer::Function::Binary, '#left' do
  subject { object.left }

  let(:described_class) { Class.new(Optimizer) { include Optimizer::Function::Binary }      }
  let(:right)           { 'Right'                                                           }
  let(:function)        { Class.new(Function) { include Function::Binary }.new(left, right) }
  let(:object)          { described_class.new(function)                                     }

  context 'when left operand is frozen' do
    let(:left) { 'Left'.freeze }

    it { should be(left) }
  end

  context 'when left operand is not frozen' do
    let(:left) { 'Left' }

    it { should_not be(left) }

    it { should be_frozen }

    it { should == left }
  end
end
