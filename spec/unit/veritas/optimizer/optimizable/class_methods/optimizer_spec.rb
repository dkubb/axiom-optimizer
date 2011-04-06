require 'spec_helper'

describe Optimizer::Optimizable::ClassMethods, '#optimizer' do
  subject { object.optimizer }

  let(:object) { Class.new { include Optimizer::Optimizable, Immutable } }

  context 'when the optimizer is not set' do
    it { should be_nil }
  end

  context 'when the optimizer is set' do
    let(:optimizer) { mock('Optimizer') }

    before do
      object.optimizer = optimizer
    end

    it { should equal(optimizer) }
  end
end

describe Optimizer::Optimizable::ClassMethods, '#optimizer=' do
  subject { object.optimizer = optimizer }

  let(:optimizer) { mock('Optimizer')                                       }
  let(:object)    { Class.new { include Optimizer::Optimizable, Immutable } }

  it 'sets the optimizer' do
    expect { subject }.to change { object.optimizer }.from(nil).to(optimizer)
  end
end
