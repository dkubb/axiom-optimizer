# encoding: utf-8

require 'spec_helper'

describe Optimizer::Algebra::Summarization, '#summarizers' do
  subject { object.summarizers }

  let(:base)          { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ])                    }
  let(:attribute)     { Attribute::Object.new(:test)                                     }
  let(:summarize_per) { TABLE_DEE                                                        }
  let(:relation)      { base.summarize(summarize_per) { |r| r.add(attribute, function) } }
  let(:object)        { described_class.new(relation)                                    }

  before do
    expect(object.operation).to be_kind_of(Algebra::Summarization)
  end

  context 'when summarizers are optimized' do
    let(:function) { base[:id].sum }

    it { should eql(relation.summarizers) }
  end

  context 'when summarizers are not optimized' do
    let(:function) { Aggregate::Sum.new(Function::Numeric::Absolute.new(1)) }

    it { should_not be(relation.summarizers) }

    it { should eql(attribute => Aggregate::Sum.new(1)) }
  end
end
