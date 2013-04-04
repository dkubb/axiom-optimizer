# encoding: utf-8

require 'spec_helper'

describe Relation::Materialized, '#optimize' do
  subject { object.optimize }

  let(:object) { described_class.new([ [ :id, Integer ] ], body) }

  context 'with an empty Array' do
    let(:body) { [] }

    it { should eql(Relation::Empty.new(object.header)) }

    it 'returns an equivalent object to the unoptimized operation' do
      should == object
    end

    it_should_behave_like 'an optimize method'
  end

  context 'with an nonempty Array' do
    let(:body) { [ [ 1 ] ] }

    it { should equal(object) }

    it_should_behave_like 'an optimize method'
  end
end
