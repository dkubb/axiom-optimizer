# encoding: utf-8

require 'spec_helper'

describe Optimizer::Function::Connective::Negation, '#operand' do
  subject { object.operand }

  let(:optimized_operand) { double('Optimized Operand')                    }
  let(:operand)           { double('Operand', optimize: optimized_operand) }
  let(:negation)          { double('Negation', operand: operand)           }
  let(:object)            { described_class.new(negation)                  }

  it { should be(optimized_operand) }
end
