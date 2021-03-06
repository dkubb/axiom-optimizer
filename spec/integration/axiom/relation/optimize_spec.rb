# encoding: utf-8

require 'spec_helper'

describe Relation, '#optimize' do
  subject { object.optimize(*args) }

  let(:object) { described_class.new([[:id, Integer]], LazyEnumerable.new([[1]])) }
  let(:args)   { []                                                               }

  before do
    expect(object).to be_instance_of(described_class)
  end

  it 'calls self.class.optimizer' do
    expect(described_class).to receive(:optimizer).and_return(nil)
    subject
  end

  it { should be(object) }

  it_should_behave_like 'an optimize method'
end
