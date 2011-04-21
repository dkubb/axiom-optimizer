require 'spec_helper'

describe Optimizer::Logic::Connective::Conjunction::Contradiction, '#optimize' do
  subject { object.optimize }

  let(:attribute)  { Attribute::Integer.new(:id)                     }
  let(:left)       { Logic::Proposition::Contradiction.instance      }
  let(:right)      { Logic::Proposition::Contradiction.instance      }
  let(:connective) { Logic::Connective::Conjunction.new(left, right) }
  let(:object)     { described_class.new(connective)                 }

  before do
    object.should be_optimizable
  end

  it { should equal(Logic::Proposition::Contradiction.instance) }
end
