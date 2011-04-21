require 'spec_helper'

describe Optimizer::Logic::Connective::Disjunction::ContradictionRightOperand, '#optimize' do
  subject { object.optimize }

  let(:attribute)  { Attribute::Integer.new(:id)                }
  let(:left)       { attribute.eq(1)                            }
  let(:right)      { Logic::Proposition::Contradiction.instance }
  let(:connective) { left.or(right)                             }
  let(:object)     { described_class.new(connective)            }

  before do
    object.should be_optimizable
  end

  it { should equal(left) }
end
