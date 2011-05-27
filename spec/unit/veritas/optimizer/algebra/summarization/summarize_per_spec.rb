# encoding: utf-8

require 'spec_helper'

describe Optimizer::Algebra::Summarization, '#summarize_per' do
  subject { object.summarize_per }

  let(:base)     { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ]) }
  let(:relation) { base.summarize(summarize_per) {}              }
  let(:object)   { described_class.new(relation)                 }

  before do
    object.operation.should be_kind_of(Algebra::Summarization)
  end

  context 'when summarize_per is optimized' do
    let(:summarize_per) { TABLE_DEE }

    it { should equal(summarize_per) }
  end

  context 'when summarize_per is not not optimized' do
   let(:summarize_per) { TABLE_DEE.rename({}) }

    it { should_not equal(summarize_per) }

    it { should equal(TABLE_DEE) }
  end
end
