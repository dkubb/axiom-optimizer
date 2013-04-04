# encoding: utf-8

require 'spec_helper'

describe Optimizer::Function, '.optimize_functions' do
  subject { object.optimize_functions(functions) }

  let(:object)    { described_class           }
  let(:attribute) { mock('Attribute')         }
  let(:functions) { { attribute => function } }

  context 'when optimizable' do
    let(:optimized) { mock('Optimized')                           }
    let(:function)  { mock('Optimizable', :optimize => optimized) }

    it { should be_frozen }

    it { should == { attribute => optimized } }
  end

  context 'when not optimizable' do
    let(:function) { mock('Not Optimizable') }

    it { should == functions }
  end
end
