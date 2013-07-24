# encoding: utf-8

require 'spec_helper'

describe Optimizer::Algebra::Extension::UnoptimizedOperand, '#optimize' do
  subject { object.optimize }

  let(:header)    { Relation::Header.coerce([[:id, Integer]])         }
  let(:base)      { Relation.new(header, LazyEnumerable.new([[1]]))   }
  let(:attribute) { Attribute::Object.new(:text)                      }
  let(:function)  { Function::Numeric::Absolute.new(1)                }
  let(:operand)   { base.rename({})                                   }
  let(:relation)  { operand.extend { |r| r.add(attribute, function) } }
  let(:object)    { described_class.new(relation)                     }

  before do
    expect(object).to be_optimizable
  end

  it { should_not be(operand) }

  it { should be_kind_of(Algebra::Extension) }

  its(:operand) { should be(base) }

  its(:extensions) { should == { attribute => 1 } }
end
