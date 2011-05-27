# encoding: utf-8

require 'spec_helper'

describe Optimizer::Function::Binary::Util, '.attribute?' do
  subject { object.attribute?(operand) }

  let(:object) { Optimizer::Function::Binary::Util }

  context 'with an attribute' do
    let(:operand) { Attribute::Integer.new(:id) }

    it { should be(true) }
  end

  context 'with a constant' do
    let(:operand) { 1 }

    it { should be(false) }
  end
end