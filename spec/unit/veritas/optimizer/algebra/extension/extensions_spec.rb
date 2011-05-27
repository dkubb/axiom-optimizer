# encoding: utf-8

require 'spec_helper'

describe Optimizer::Algebra::Extension, '#extensions' do
  subject { object.extensions }

  let(:base)          { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ])  }
  let(:attribute)     { Attribute::Object.new(:test)                   }
  let(:summarize_per) { TABLE_DEE                                      }
  let(:relation)      { base.extend { |r| r.add(attribute, function) } }
  let(:object)        { described_class.new(relation)                  }

  before do
    object.operation.should be_kind_of(Algebra::Extension)
  end

  context 'when extensions are optimized' do
    let(:function) { 1 }

    it { should eql(relation.extensions) }
  end

  context 'when extensions are not optimized' do
    let(:function) { Function::Numeric::Absolute.new(1) }

    it { should_not equal(relation.extensions) }

    it { should eql(attribute => 1) }
  end
end
