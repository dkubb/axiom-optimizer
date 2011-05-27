# encoding: utf-8

require 'spec_helper'

describe Optimizer::Function::Binary, '.optimize_operand' do
  subject { object.optimize_operand(predicate) }

  let(:object) { self.class.described_type }

  context 'when optimizable' do
    let(:optimized) { mock('Optimized')                           }
    let(:predicate) { mock('Optimizable', :optimize => optimized) }

    it { should equal(optimized) }
  end

  context 'when not optimizable' do
    let(:predicate) { mock('Not Optimizable') }

    it { should equal(predicate) }
  end
end
