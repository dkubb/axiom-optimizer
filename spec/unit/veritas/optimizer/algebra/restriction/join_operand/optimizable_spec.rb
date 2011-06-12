# encoding: utf-8

require 'spec_helper'

describe Optimizer::Algebra::Restriction::JoinOperand, '#optimizable?' do
  subject { object.optimizable? }

  let(:left)      { Relation.new([ [ :id, Integer ], [ :user_name,     String ] ], [ [ 1, 'Dan Kubb' ] ].each) }
  let(:right)     { Relation.new([ [ :id, Integer ], [ :employee_name, String ] ], [ [ 2, 'Dan Kubb' ] ].each) }
  let(:relation)  { operand.restrict { predicate }                                                             }
  let(:object)    { described_class.new(relation)                                                              }

  before do
    object.operation.should be_kind_of(Algebra::Restriction)
  end

  context 'when the operand is a join operation and the predicate distributes to the left' do
    let(:operand)   { left.join(right)                }
    let(:predicate) { left[:user_name].eq('Dan Kubb') }

    it { should be(true) }
  end

  context 'when the operand is a join operation and the predicate distributes to the right' do
    let(:operand)   { left.join(right)                     }
    let(:predicate) { right[:employee_name].eq('Dan Kubb') }

    it { should be(true) }
  end

  context 'when the operand is a join operation and the predicate distributes to the left and right' do
    let(:operand)   { left.join(right) }
    let(:predicate) { left[:id].eq(1)  }

    it { should be(true) }
  end

  context 'when the operand is a join operation and the predicate does not distribute to the left and right' do
    let(:operand)   { left.join(right)                           }
    let(:predicate) { left[:user_name].eq(right[:employee_name]) }

    it { should be(false) }
  end

  context 'when the operand is not a join operation' do
    let(:operand)   { left }
    let(:predicate) { true }

    it { should be(false) }
  end
end
