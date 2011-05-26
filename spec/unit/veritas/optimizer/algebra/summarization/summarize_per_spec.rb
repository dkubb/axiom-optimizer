# encoding: utf-8

require 'spec_helper'

describe Optimizer::Algebra::Summarization, '#summarize_per' do
  subject { object.summarize_per }

  let(:base)          { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ]) }
  let(:summarize_per) { TABLE_DEE                                     }
  let(:relation)      { base.summarize(summarize_per) {}              }
  let(:object)        { described_class.new(relation)                 }

  before do
    object.operation.should be_kind_of(Algebra::Summarization)
  end

  it { should equal(summarize_per) }
end
