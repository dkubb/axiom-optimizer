# encoding: utf-8

require 'spec_helper'

describe Optimizer::Function::Binary::Util, '.constant?' do
  subject { object.constant?(operand) }

  let(:object) { Optimizer::Function::Binary::Util }

  context 'with a constant' do
    let(:operand) { 1 }

    it { should be(true) }
  end

  context 'with an attribute' do
    let(:operand) { Attribute::Integer.new(:id) }

    it { should be(false) }
  end

  context 'with a nil' do
    let(:operand) { nil }

    it { should be(false) }
  end
end
