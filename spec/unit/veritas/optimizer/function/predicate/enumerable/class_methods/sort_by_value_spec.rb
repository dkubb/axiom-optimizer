# encoding: utf-8

require 'spec_helper'

describe Optimizer::Function::Predicate::Enumerable, '.sort_by_value' do
  subject { object.sort_by_value(value) }

  let(:object) { self.class.described_type }

  context 'when the value is true' do
    let(:value) { true }

    it { should eql(1) }
  end

  context 'when the value is false' do
    let(:value) { false }

    it { should eql(0) }
  end

  context 'when the value is an object' do
    let(:value) { Object.new }

    it { should equal(value) }
  end
end
