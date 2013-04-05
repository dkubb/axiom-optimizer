# encoding: utf-8

require 'spec_helper'

describe Function, '#optimize' do
  subject { object.optimize(*args) }

  let(:described_class) { Class.new(Function) }
  let(:object)          { described_class.new }
  let(:args)            { []                  }

  before do
    described_class.class_eval do
      def eql?(other)
        instance_of?(other.class)
      end
    end
  end

  it 'calls self.class.optimizer' do
    described_class.should_receive(:optimizer).and_return(nil)
    subject
  end

  it 'returns self' do
    should equal(object)
  end

  it_should_behave_like 'an optimize method'
end