# encoding: utf-8

require 'spec_helper'

describe Optimizer::Function::Connective::Conjunction::TautologyLeft, '#optimizable?' do
  subject { object.optimizable? }

  let(:attribute)  { Attribute::Integer.new(:id)                        }
  let(:connective) { Function::Connective::Conjunction.new(left, right) }
  let(:object)     { described_class.new(connective)                    }

  before do
    expect(object.operation).to be_kind_of(Function::Connective::Conjunction)
  end

  context 'when right is a tautology' do
    let(:left)  { Function::Proposition::Tautology.instance }
    let(:right) { attribute.eq(1)                           }

    it { should be(true) }
  end

  context 'when right is not a tautology' do
    let(:left)  { attribute.eq(1) }
    let(:right) { attribute.eq(1) }

    it { should be(false) }
  end
end
