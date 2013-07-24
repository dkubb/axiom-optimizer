# encoding: utf-8

require 'spec_helper'

describe Optimizer::Optimizable, '#optimize' do
  subject { object.optimize }

  let(:described_class) { Class.new { include Optimizer::Optimizable, Adamantium } }
  let(:object)          { described_class.new                                      }

  context 'when there is no optimizer for the class' do
    it { should equal(object) }

    it_should_behave_like 'an optimize method'
  end

  context 'when there is an optimizer for the class' do
    let(:optimized) { double('Optimized', :frozen? => true)   }
    let(:optimizer) { double('Optimizer', :call => optimized) }

    before do
      described_class.optimizer = optimizer
      optimized.stub(:optimize).and_return(optimized)
    end

    it { should equal(optimized) }

    it 'calls the optimizer with the object' do
      optimizer.should_receive(:call).with(object).and_return(optimized)
      should equal(optimized)
    end

    it '#optimize the optimized object' do
      optimized.should_receive(:optimize).with(no_args).and_return(optimized)
      should equal(optimized)
    end
  end
end
