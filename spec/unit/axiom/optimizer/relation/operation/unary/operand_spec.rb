# encoding: utf-8

require 'spec_helper'

describe Optimizer::Relation::Operation::Unary, '#operand' do
  subject { object.operand }

  let(:described_class) { Class.new(Optimizer::Relation::Operation::Unary)         }
  let(:optimized)       { mock('Optimized')                                        }
  let(:operand)         { mock('Operand', :optimize => optimized)                  }
  let(:header)          { mock('Header')                                           }
  let(:relation)        { mock('Relation', :operand => operand, :header => header) }
  let(:object)          { described_class.new(relation)                            }

  it { should equal(optimized) }
end
