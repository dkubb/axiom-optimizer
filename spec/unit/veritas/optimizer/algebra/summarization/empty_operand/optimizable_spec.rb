# encoding: utf-8

require 'spec_helper'

describe Optimizer::Algebra::Summarization::EmptyOperand, '#optimizable?' do
  subject { object.optimizable? }

  let(:header)        { Relation::Header.new([ [ :id, Integer ], [ :name, String ] ]) }
  let(:base)          { Relation.new(header, [ [ 1, 'Dan Kubb' ] ].each)              }
  let(:relation)      { operand.summarize(summarize_per) {}                           }
  let(:summarize_per) { TABLE_DEE                                                     }
  let(:object)        { described_class.new(relation)                                 }

  before do
    object.operation.should be_kind_of(Algebra::Summarization)
  end

  context 'when the operand is empty' do
    let(:operand) { base.restrict { false } }

    it { should be(true) }
  end

  context 'when the operand is not empty' do
    let(:operand) { base }

    it { should be(false) }
  end
end
