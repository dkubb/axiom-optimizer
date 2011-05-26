# encoding: utf-8

require 'spec_helper'

describe Optimizer::Algebra::Summarization::UnoptimizedOperand, '#optimize' do
  subject { object.optimize }

  let(:header)        { Relation::Header.new([ [ :id, Integer ] ])                          }
  let(:base)          { Relation.new(header, [ [ 1 ] ].each)                                }
  let(:attribute)     { Attribute::Object.new(:text)                                        }
  let(:function)      { lambda { |acc, tuple| 1 }                                           }
  let(:operand)       { base.rename({})                                                     }
  let(:summarize_per) { TABLE_DEE.project([])                                               }
  let(:relation)      { operand.summarize(summarize_per) { |r| r.add(attribute, function) } }
  let(:object)        { described_class.new(relation)                                       }

  before do
    object.should be_optimizable
  end

  it { should be_kind_of(Algebra::Summarization) }

  it { should_not equal(operand) }

  its(:operand) { should equal(base) }

  its(:summarize_per) { should equal(TABLE_DEE) }

  its(:summarizers) { should == { attribute => function } }
end
