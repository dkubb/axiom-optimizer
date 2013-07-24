# encoding: utf-8

require 'spec_helper'

describe Optimizer::Algebra::Summarization::UnoptimizedOperand, '#optimizable?' do
  subject { object.optimizable? }

  let(:header)    { Relation::Header.coerce([[:id, Integer], [:name, String]])          }
  let(:base)      { Relation.new(header, LazyEnumerable.new([[1, 'Dan Kubb']]))         }
  let(:attribute) { Attribute::Object.new(:test)                                        }
  let(:relation)  { operand.summarize(summarize_per) { |r| r.add(attribute, function) } }
  let(:object)    { described_class.new(relation)                                       }

  before do
    expect(object.operation).to be_kind_of(Algebra::Summarization)
  end

  context 'when the operand is optimizable' do
    let(:operand)       { base.rename({})       }
    let(:summarize_per) { TABLE_DEE             }
    let(:function)      { Aggregate::Sum.new(1) }

    it { should be(true) }
  end

  context 'when summarize_per is optimizable' do
    let(:operand)       { base                  }
    let(:summarize_per) { TABLE_DEE.rename({})  }
    let(:function)      { Aggregate::Sum.new(1) }

    it { should be(true) }
  end

  context 'when summarizers are optimizable' do
    let(:operand)       { base                                                   }
    let(:summarize_per) { TABLE_DEE.rename({})                                   }
    let(:function)      { Aggregate::Sum.new(Function::Numeric::Absolute.new(1)) }

    it { should be(true) }
  end

  context 'when the operand, summarize_per and summarizers are not optimizable' do
    let(:operand)       { base                  }
    let(:summarize_per) { TABLE_DEE             }
    let(:function)      { Aggregate::Sum.new(1) }

    it { should be(false) }
  end
end
