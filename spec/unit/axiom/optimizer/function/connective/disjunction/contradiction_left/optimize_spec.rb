# encoding: utf-8

require 'spec_helper'

describe Optimizer::Function::Connective::Disjunction::ContradictionLeft, '#optimize' do
  subject { object.optimize }

  let(:attribute)  { Attribute::Integer.new(:id)                        }
  let(:left)       { Function::Proposition::Contradiction.instance      }
  let(:right)      { attribute.eq(1)                                    }
  let(:connective) { Function::Connective::Disjunction.new(left, right) }
  let(:object)     { described_class.new(connective)                    }

  before do
    expect(object).to be_optimizable
  end

  it { should be(right) }
end
