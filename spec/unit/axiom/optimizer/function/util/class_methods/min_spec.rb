# encoding: utf-8

require 'spec_helper'

describe Optimizer::Function::Util, '.min' do
  subject { object.min(operand) }

  let(:object) { Optimizer::Function::Util }

  context 'with an Integer attribute' do
    let(:operand) { Attribute::Integer.new(:id, size: 1..10) }

    it { should == 1 }
  end

  context 'with a String attribute' do
    let(:operand) { Attribute::String.new(:id, minimum_length: 1, maximum_length: 10) }

    it { should == 1 }
  end

  context 'with a constat' do
    let(:operand) { 1 }

    it { should == 1 }
  end
end
