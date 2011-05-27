# encoding: utf-8

require 'spec_helper'

describe Optimizer::Function::Predicate::Contradiction, '#optimize' do
  subject { object.optimize }

  let(:described_class) { Class.new(Optimizer) { include Optimizer::Function::Binary } }
  let(:attribute)       { Attribute::Integer.new(:id)                                  }
  let(:predicate)       { Function::Predicate::Inequality.new(attribute, attribute)    }
  let(:object)          { described_class.new(predicate)                               }

  before do
    described_class.class_eval { include Optimizer::Function::Predicate::Contradiction }
  end

  it { should equal(Function::Proposition::Contradiction.instance) }
end
