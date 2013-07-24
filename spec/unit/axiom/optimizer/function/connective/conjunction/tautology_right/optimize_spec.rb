# encoding: utf-8

require 'spec_helper'

describe Optimizer::Function::Connective::Conjunction::TautologyRight, '#optimize' do
  subject { object.optimize }

  let(:attribute)  { Attribute::Integer.new(:id)               }
  let(:left)       { attribute.eq(1)                           }
  let(:right)      { Function::Proposition::Tautology.instance }
  let(:connective) { left.and(right)                           }
  let(:object)     { described_class.new(connective)           }

  before do
    expect(object).to be_optimizable
  end

  it { should be(left) }
end
