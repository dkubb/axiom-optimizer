# encoding: utf-8

require 'spec_helper'

describe Optimizer::Function::Binary::UnoptimizedOperands, '#optimizable?' do
  subject { object.optimizable? }

  let(:attribute)       { Attribute::Integer.new(:id)                                       }
  let(:described_class) { Class.new(Optimizer) { include Optimizer::Function::Binary }      }
  let(:function)        { Class.new(Function) { include Function::Binary }.new(left, right) }
  let(:object)          { described_class.new(function)                                     }

  before do
    described_class.class_eval { include Optimizer::Function::Binary::UnoptimizedOperands }
  end

  context 'when left is optimizable' do
    let(:left)  { attribute.include([ 1 ]) }
    let(:right) { attribute.ne(2)          }

    it { should be(true) }
  end

  context 'when right is optimizable' do
    let(:left)  { attribute.eq(1)          }
    let(:right) { attribute.exclude([ 2 ]) }

    it { should be(true) }
  end

  context 'when left and right are not optimizable' do
    let(:left)  { attribute.eq(1) }
    let(:right) { attribute.ne(2) }

    it { should be(false) }
  end
end
