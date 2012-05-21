# encoding: utf-8

require 'spec_helper'

describe Optimizer, '.chain' do
  let(:operation)       { mock('Operation')    }
  let(:object)          { Optimizer            }
  let(:identity)        { object::Identity     }
  let(:optimizer_class) { Class.new(Optimizer) }

  context 'with no optimizers' do
    subject { object.chain }

    it { should equal(identity) }

    it 'returns a block that returns the operation' do
      subject.call(operation).should equal(operation)
    end
  end

  context 'with an optimizer that can optimize the operation' do
    subject { object.chain(optimizer_class) }

    let(:optimized) { mock('Optimized') }

    before do
      optimized = self.optimized
      optimizer_class.send(:define_method, :optimizable?) { true      }
      optimizer_class.send(:define_method, :optimize)     { optimized }
    end

    it { should_not equal(identity) }

    it { should be_kind_of(Proc) }

    it 'returns a block that optimizes the operation' do
      subject.call(operation).should equal(optimized)
    end
  end

  context 'with an optimizer that cannot optimize the operation' do
    subject { object.chain(optimizer_class) }

    before do
      optimizer_class.send(:define_method, :optimizable?) { false }
    end

    it { should_not equal(identity) }

    it { should be_kind_of(Proc) }

    it 'returns a block that calls the successor (Identity) with the operation' do
      subject.call(operation).should equal(operation)
    end
  end
end
