# encoding: utf-8

require 'spec_helper'

describe Optimizer::Relation::Operation::Unary, '#operand' do
  subject { object.operand }

  let(:described_class) { Class.new(Optimizer::Relation::Operation::Unary)           }
  let(:optimized)       { double('Optimized')                                        }
  let(:operand)         { double('Operand', :optimize => optimized)                  }
  let(:header)          { double('Header')                                           }
  let(:relation)        { double('Relation', :operand => operand, :header => header) }
  let(:object)          { described_class.new(relation)                              }

  it { should be(optimized) }
end
