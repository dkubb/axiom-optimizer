# encoding: utf-8

require 'spec_helper'

describe Optimizer::Function::Binary::UnoptimizedOperands, '#optimize' do
  subject { object.optimize }

  let(:described_class) { Class.new(Optimizer) { include Optimizer::Function::Binary }      }
  let(:attribute)       { Attribute::Integer.new(:id)                                       }
  let(:left)            { attribute.include([1])                                            }
  let(:right)           { attribute.exclude([2])                                            }
  let(:function)        { Class.new(Function) { include Function::Binary }.new(left, right) }
  let(:object)          { described_class.new(function)                                     }

  before do
    described_class.class_eval { include Optimizer::Function::Binary::UnoptimizedOperands }
    expect(object).to be_optimizable
  end

  its(:left) { should eql(attribute.eq(1)) }

  its(:right) { should eql(attribute.ne(2)) }
end
