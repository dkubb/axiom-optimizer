# encoding: utf-8

require 'spec_helper'

describe Optimizer::Function, '.optimize_operand' do
  subject { object.optimize_operand(function) }

  let(:object) { described_class }

  context 'when optimizable' do
    let(:optimized) { double('Optimized')                        }
    let(:function)  { double('Optimizable', optimize: optimized) }

    it { should be(optimized) }
  end

  context 'when not optimizable' do
    let(:function) { double('Not Optimizable') }

    it { should be(function) }
  end
end
