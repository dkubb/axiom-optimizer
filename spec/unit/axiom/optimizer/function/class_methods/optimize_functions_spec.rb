# encoding: utf-8

require 'spec_helper'

describe Optimizer::Function, '.optimize_functions' do
  subject { object.optimize_functions(functions) }

  let(:object)    { described_class           }
  let(:attribute) { double('Attribute')       }
  let(:functions) { { attribute => function } }

  context 'when optimizable' do
    let(:optimized) { double('Optimized')                           }
    let(:function)  { double('Optimizable', :optimize => optimized) }

    it { should be_frozen }

    it { should == { attribute => optimized } }
  end

  context 'when not optimizable' do
    let(:function) { double('Not Optimizable') }

    it { should == functions }
  end
end
