require 'spec_helper'

describe Optimizer::Function::Predicate, '#left' do
  subject { object.left }

  let(:right)     { 'Right'                                         }
  let(:predicate) { Class.new(Function::Predicate).new(left, right) }
  let(:object)    { described_class.new(predicate)                  }

  context 'when left operand is frozen' do
    let(:left) { 'Left'.freeze }

    it { should equal(left) }
  end

  context 'when left operand is not frozen' do
    let(:left) { 'Left' }

    it { should_not equal(left) }

    it { should be_frozen }

    it { should == left }
  end
end
