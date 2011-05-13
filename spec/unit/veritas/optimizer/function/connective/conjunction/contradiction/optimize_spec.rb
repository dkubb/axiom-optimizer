require 'spec_helper'

describe Optimizer::Function::Connective::Conjunction::Contradiction, '#optimize' do
  subject { object.optimize }

  let(:attribute)  { Attribute::Integer.new(:id)                        }
  let(:left)       { Function::Proposition::Contradiction.instance      }
  let(:right)      { Function::Proposition::Contradiction.instance      }
  let(:connective) { Function::Connective::Conjunction.new(left, right) }
  let(:object)     { described_class.new(connective)                    }

  before do
    object.should be_optimizable
  end

  it { should equal(Function::Proposition::Contradiction.instance) }
end
