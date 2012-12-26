# encoding: utf-8

require 'spec_helper'

describe Optimizer::Algebra::Summarization::EmptySummarizePer, '#optimize' do
  subject { object.optimize }

  let(:header)        { Relation::Header.coerce([ [ :id, Integer ], [ :name, String ] ])        }
  let(:base)          { Relation.new(header, LazyEnumerable.new([ [ 1, 'Dan Kubb' ] ]))         }
  let(:attribute)     { Attribute::Object.new(:test)                                            }
  let(:operand)       { base                                                                    }
  let(:summarize_per) { base.project([ :id ]).restrict { false }                                }
  let(:relation)      { operand.summarize(summarize_per) { |r| r.add(attribute, r.name.count) } }
  let(:object)        { described_class.new(relation)                                           }

  before do
    object.should be_optimizable
  end

  it { should be_kind_of(Relation::Empty) }

  its(:header) { should == [ [ :id, Integer ], [ :test, Object ] ] }

  its(:tuples) { should equal(relation) }
end
