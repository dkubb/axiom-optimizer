# encoding: utf-8

require 'spec_helper'

describe Optimizer::Optimizable::ClassMethods, '#optimizer' do
  subject { object.optimizer }

  let(:object) { Class.new { include Optimizer::Optimizable, Adamantium } }

  context 'when the optimizer is not set' do
    it { should be_nil }
  end

  context 'when the optimizer is set' do
    let(:optimizer) { double('Optimizer') }

    before do
      object.optimizer = optimizer
    end

    it { should be(optimizer) }
  end
end

describe Optimizer::Optimizable::ClassMethods, '#optimizer=' do
  subject { object.optimizer = optimizer }

  let(:optimizer) { double('Optimizer')                                      }
  let(:object)    { Class.new { include Optimizer::Optimizable, Adamantium } }

  it 'sets the optimizer' do
    expect { subject }.to change { object.optimizer }.from(nil).to(optimizer)
  end
end
