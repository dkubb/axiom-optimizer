# encoding: utf-8

require 'spec_helper'

describe Relation, '#optimize' do
  subject { object.optimize(*args) }

  let(:object) { described_class.new([ [ :id, Integer ] ], LazyEnumerable.new([ [ 1 ] ])) }
  let(:args)   { []                                                                       }

  before do
    object.should be_instance_of(described_class)
  end

  it 'calls self.class.optimizer' do
    described_class.should_receive(:optimizer).and_return(nil)
    subject
  end

  it { should equal(object) }

  it_should_behave_like 'an optimize method'
end
