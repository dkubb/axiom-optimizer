# encoding: utf-8

require 'spec_helper'

describe Optimizer::Algebra::Summarization::EmptySummarizePer, '#optimizable?' do
  subject { object.optimizable? }

  let(:header)   { Relation::Header.coerce([ [ :id, Integer ], [ :name, String ] ]) }
  let(:base)     { Relation.new(header, LazyEnumerable.new([ [ 1, 'Dan Kubb' ] ]))  }
  let(:operand)  { base                                                             }
  let(:relation) { operand.summarize(summarize_per) {}                              }
  let(:object)   { described_class.new(relation)                                    }

  before do
    expect(object.operation).to be_kind_of(Algebra::Summarization)
  end

  context 'when the summarize_per is empty' do
    let(:summarize_per) { base.project([ :id ]).restrict { false } }

    it { should be(true) }
  end

  context 'when the summarize_per is not empty' do
    let(:summarize_per) { base.project([ :id ]) }

    it { should be(false) }
  end
end
