# encoding: utf-8

require 'spec_helper'

describe Optimizer::Algebra::Restriction::ProductOperand, '#optimize' do
  subject { object.optimize }

  let(:left)                { Relation.new([[:user_id, Integer], [:user_name, String]], LazyEnumerable.new([[1, 'Dan Kubb']]))         }
  let(:right)               { Relation.new([[:employee_id, Integer], [:employee_name, String]], LazyEnumerable.new([[2, 'Dan Kubb']])) }
  let(:operand)             { left.product(right)                                                                                      }
  let(:left_predicate)      { left[:user_name].eq('Dan Kubb')                                                                          }
  let(:right_predicate)     { right[:employee_name].eq('Dan Kubb')                                                                     }
  let(:remainder_predicate) { left[:user_name].eq(right[:employee_name])                                                               }
  let(:predicate)           { left_predicate.and(right_predicate).and(remainder_predicate)                                             }
  let(:relation)            { operand.restrict { predicate }                                                                           }
  let(:object)              { described_class.new(relation)                                                                            }

  before do
    expect(object).to be_optimizable
  end

  it { should be_kind_of(Algebra::Restriction) }

  its(:operand) { should be_kind_of(Algebra::Product) }

  it 'wraps the left operand of the product in a restriction' do
    left_operand = subject.operand.left
    expect(left_operand.operand).to be(left)
    expect(left_operand).to be_kind_of(Algebra::Restriction)
  end

  it 'wraps the right operand of the product in a restriction' do
    right_operand = subject.operand.right
    expect(right_operand.operand).to be(right)
    expect(right_operand).to be_kind_of(Algebra::Restriction)
  end

  it 'distributes the applicable part of the predicate to the left' do
    expect(subject.operand.left.predicate).to be(left_predicate)
  end

  it 'distributes the applicable part of the predicate to the right' do
    expect(subject.operand.right.predicate).to be(right_predicate)
  end

  # keeps the remainder that applies to the left and right
  its(:predicate) { should be(remainder_predicate) }
end
