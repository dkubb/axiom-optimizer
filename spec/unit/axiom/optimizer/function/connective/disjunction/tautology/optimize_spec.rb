# encoding: utf-8

require 'spec_helper'

describe Optimizer::Function::Connective::Disjunction::Tautology, '#optimize' do
  subject { object.optimize }

  let(:attribute)  { Attribute::Integer.new(:id)                        }
  let(:left)       { Function::Proposition::Tautology.instance          }
  let(:right)      { Function::Proposition::Tautology.instance          }
  let(:connective) { Function::Connective::Disjunction.new(left, right) }
  let(:object)     { described_class.new(connective)                    }

  before do
    object.should be_optimizable
  end

  it { should equal(Function::Proposition::Tautology.instance) }
end
