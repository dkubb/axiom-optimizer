# encoding: utf-8

require 'spec_helper'

describe Optimizer::Algebra::Restriction::ProductOperand, '#optimize' do
  subject { object.optimize }

  let(:left)                { Relation.new([ [ :user_id,     Integer ], [ :user_name,     String ] ], [ [ 1, 'Dan Kubb' ] ].each) }
  let(:right)               { Relation.new([ [ :employee_id, Integer ], [ :employee_name, String ] ], [ [ 2, 'Dan Kubb' ] ].each) }
  let(:operand)             { left.product(right)                                                                                 }
  let(:left_predicate)      { left[:user_name].eq('Dan Kubb')                                                                     }
  let(:right_predicate)     { right[:employee_name].eq('Dan Kubb')                                                                }
  let(:remainder_predicate) { left[:user_name].eq(right[:employee_name])                                                          }
  let(:predicate)           { left_predicate.and(right_predicate).and(remainder_predicate)                                        }
  let(:relation)            { operand.restrict { predicate }                                                                      }
  let(:object)              { described_class.new(relation)                                                                       }

  before do
    object.should be_optimizable
  end

  it { should be_kind_of(Algebra::Restriction) }

  its(:operand) { should be_kind_of(Algebra::Product) }

  it 'wraps the left operand of the product in a restriction' do
    left_operand = subject.operand.left
    left_operand.operand.should equal(left)
    left_operand.should be_kind_of(Algebra::Restriction)
  end

  it 'wraps the right operand of the product in a restriction' do
    right_operand = subject.operand.right
    right_operand.operand.should equal(right)
    right_operand.should be_kind_of(Algebra::Restriction)
  end

  it 'distributes the applicable part of the predicate to the left' do
    subject.operand.left.predicate.should equal(left_predicate)
  end

  it 'distributes the applicable part of the predicate to the right' do
    subject.operand.right.predicate.should equal(right_predicate)
  end

  # keeps the remainder that applies to the left and right
  its(:predicate) { should equal(remainder_predicate) }
end
