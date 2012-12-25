# encoding: utf-8

require 'spec_helper'

describe Optimizer::Algebra::Summarization::EmptyOperand, '#optimize' do
  subject { object.optimize }

  let(:header)        { Relation::Header.coerce([ [ :id, Integer ] ]) }
  let(:base)          { Relation.new(header, [ [ 1 ] ].each)          }
  let(:attribute)     { Attribute::Object.new(:test)                  }
  let(:operand)       { base.restrict { false }                       }
  let(:summarize_per) { TABLE_DEE                                     }
  let(:object)        { described_class.new(relation)                 }

  context 'when the function has a default' do
    let(:relation) { operand.summarize(summarize_per) { |r| r.add(attribute, r.id.count) } }

    before do
      object.should be_optimizable
    end

    it { should be_kind_of(Algebra::Extension) }

    it { should_not equal(operand) }

    its(:operand) { should equal(summarize_per) }

    its(:extensions) { should == { attribute => 0 } }
  end

  context 'when the function does not have a default' do
    let(:function) { lambda { |acc, tuple| 1 }                                           }
    let(:relation) { operand.summarize(summarize_per) { |r| r.add(attribute, function) } }

    before do
      object.should be_optimizable
    end

    it { should be_kind_of(Algebra::Extension) }

    it { should_not equal(operand) }

    its(:operand) { should equal(summarize_per) }

    its(:extensions) { should == { attribute => nil } }
  end
end
