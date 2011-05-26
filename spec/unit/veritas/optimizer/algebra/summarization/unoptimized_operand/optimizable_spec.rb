# encoding: utf-8

require 'spec_helper'

describe Optimizer::Algebra::Summarization::UnoptimizedOperand, '#optimizable?' do
  subject { object.optimizable? }

  let(:header)   { Relation::Header.new([ [ :id, Integer ], [ :name, String ] ]) }
  let(:base)     { Relation.new(header, [ [ 1, 'Dan Kubb' ] ].each)              }
  let(:relation) { operand.summarize(summarize_per) {}                           }
  let(:object)   { described_class.new(relation)                                 }

  before do
    object.operation.should be_kind_of(Algebra::Summarization)
  end

  context 'when the operand and summarize_per are optimizable' do
    let(:operand)       { base.rename({})      }
    let(:summarize_per) { TABLE_DEE.rename({}) }

    it { should be(true) }
  end

  context 'when the operand is optimizable, summarize_per is not optimizable' do
    let(:operand)       { base.rename({}) }
    let(:summarize_per) { TABLE_DEE       }

    it { should be(true) }
  end

  context 'when the operand is not optimizable, summarize_per is optimizable' do
    let(:operand)       { base                 }
    let(:summarize_per) { TABLE_DEE.rename({}) }

    it { should be(true) }
  end

  context 'when the operand and summarize_per are not optimizable' do
    let(:operand)       { base      }
    let(:summarize_per) { TABLE_DEE }

    it { should be(false) }
  end
end
