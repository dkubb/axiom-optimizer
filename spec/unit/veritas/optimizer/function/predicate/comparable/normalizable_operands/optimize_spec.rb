# encoding: utf-8

require 'spec_helper'

describe Optimizer::Function::Predicate::Comparable::NormalizableOperands, '#optimize' do
  subject { object.optimize }

  let(:attribute) { Attribute::Integer.new(:id)                     }
  let(:predicate) { Function::Predicate::Equality.new(1, attribute) }
  let(:object)    { described_class.new(predicate)                  }

  before do
    object.should be_optimizable
  end

  it { should be_kind_of(Function::Predicate::Equality) }

  its(:left) { should equal(attribute) }

  its(:right) { should == 1 }
end
