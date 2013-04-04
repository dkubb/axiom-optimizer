# encoding: utf-8

require 'spec_helper'

describe Optimizer::Function, '.optimize_operand' do
  subject { object.optimize_operand(function) }

  let(:object) { described_class }

  context 'when optimizable' do
    let(:optimized) { mock('Optimized')                           }
    let(:function)  { mock('Optimizable', :optimize => optimized) }

    it { should equal(optimized) }
  end

  context 'when not optimizable' do
    let(:function) { mock('Not Optimizable') }

    it { should equal(function) }
  end
end
