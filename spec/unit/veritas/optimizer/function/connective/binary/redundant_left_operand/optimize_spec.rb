# encoding: utf-8

require 'spec_helper'

describe Optimizer::Function::Connective::Binary::RedundantLeftOperand, '#optimize' do
  subject { object.optimize }

  let(:attribute)  { Attribute::Integer.new(:id)     }
  let(:left)       { attribute.include([ 1 ])        }
  let(:right)      { attribute.exclude([ 2 ])        }
  let(:connective) { left.and(right).and(right)      }
  let(:object)     { described_class.new(connective) }

  before do
    object.should be_optimizable
  end

  it { should be_kind_of(Function::Connective::Conjunction) }

  its(:left) { should eql(attribute.eq(1)) }

  its(:right) { should eql(attribute.ne(2)) }
end
