require 'spec_helper'

describe Optimizer::Function::Predicate::Util, '.constant?' do
  subject { object.constant?(operand) }

  let(:object) { Optimizer::Function::Predicate::Util }

  context 'with an attribute' do
    let(:operand) { Attribute::Integer.new(:id) }

    it { should be(false) }
  end

  context 'with a constant' do
    let(:operand) { 1 }

    it { should be(true) }
  end
end
