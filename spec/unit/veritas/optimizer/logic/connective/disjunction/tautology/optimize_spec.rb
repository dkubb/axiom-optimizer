require 'spec_helper'

describe Optimizer::Logic::Connective::Disjunction::Tautology, '#optimize' do
  subject { object.optimize }

  let(:attribute)  { Attribute::Integer.new(:id)                     }
  let(:left)       { Logic::Proposition::Tautology.instance          }
  let(:right)      { Logic::Proposition::Tautology.instance          }
  let(:connective) { Logic::Connective::Disjunction.new(left, right) }
  let(:object)     { described_class.new(connective)                 }

  before do
    object.should be_optimizable
  end

  it { should equal(Logic::Proposition::Tautology.instance) }
end
