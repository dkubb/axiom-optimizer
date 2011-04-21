require 'spec_helper'

describe Optimizer::Logic::Predicate::Contradiction, '#optimize' do
  subject { object.optimize }

  let(:described_class) { Class.new(Optimizer::Logic::Predicate)                 }
  let(:attribute)       { Attribute::Integer.new(:id)                            }
  let(:predicate)       { Logic::Predicate::Inequality.new(attribute, attribute) }
  let(:object)          { described_class.new(predicate)                         }

  before do
    described_class.class_eval { include Optimizer::Logic::Predicate::Contradiction }
  end

  it { should equal(Logic::Proposition::Contradiction.instance) }
end
