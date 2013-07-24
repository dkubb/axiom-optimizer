# encoding: utf-8

require 'spec_helper'

describe Optimizer::PredicatePartition, '#right' do
  subject { object.right }

  let(:left_header)  { Relation::Header.coerce([ [ :id, Integer ], [ :user_name,     String ], Attribute::Boolean.new(:active_user),     Attribute::Boolean.new(:active) ]) }
  let(:right_header) { Relation::Header.coerce([ [ :id, Integer ], [ :employee_name, String ], Attribute::Boolean.new(:active_employee), Attribute::Boolean.new(:active) ]) }
  let(:object)       { described_class.new(predicate, left_header, right_header)                                                                                            }

  context 'when the predicate is a tautology' do
    let(:predicate) { Function::Proposition::Tautology.instance }

    it 'partitions the predicate to the right' do
      should be(Function::Proposition::Tautology.instance)
    end
  end

  context 'when the predicate is a contradiction' do
    let(:predicate) { Function::Proposition::Contradiction.instance }

    it 'partitions the predicate to the right' do
      should be(Function::Proposition::Contradiction.instance)
    end
  end

  context 'when the predicate is an attribute' do
    context 'with an attribute from the left header, but not the right header' do
      let(:predicate) { left_header[:active_user] }

      it 'does not partition the predicate to the left' do
        should be(Function::Proposition::Tautology.instance)
      end
    end

    context 'with an attribute from the right header, but not the left header' do
      let(:predicate) { right_header[:active_employee] }

      it 'partitions the predicate to the right' do
        should be(predicate)
      end
    end

    context 'with an attribute from the left and right header' do
      let(:predicate) { right_header[:active] }

      it 'partitions the predicate to the right' do
        should be(predicate)
      end
    end
  end

  context 'when the predicate is a binary predicate' do
    context 'with an attribute from the left header, but not the right header' do
      let(:predicate) { left_header[:user_name].eq('Dan Kubb') }

      it 'does not partition the predicate to the right' do
        should be(Function::Proposition::Tautology.instance)
      end
    end

    context 'with an attribute from the right header, but not the left header' do
      let(:predicate) { right_header[:employee_name].eq('Dan Kubb') }

      it 'partitions the predicate to the right' do
        should be(predicate)
      end
    end

    context 'with an attribute from the left and right header' do
      let(:predicate) { right_header[:id].eq(1) }

      it 'partitions the predicate to the right' do
        should be(predicate)
      end
    end

    context 'with an attribute from the left header, and an attribute from the left and right header' do
      let(:predicate) { left_header[:active_user].eq(right_header[:active]) }

      it 'partitions the predicate to the right' do
        should be(predicate)
      end
    end

    context 'with an attribute from the right header, and an attribute from the left and right header' do
      let(:predicate) { right_header[:active_employee].eq(right_header[:active]) }

      it 'partitions the predicate to the right' do
        should be(predicate)
      end
    end

    context 'with disjoint attributes from the left and right header' do
      let(:predicate) { left_header[:user_name].eq(right_header[:employee_name]) }

      it 'does not partition the predicate to the right' do
        should be(Function::Proposition::Tautology.instance)
      end
    end
  end

  context 'when the predicate is a negation' do
    context 'with an attribute from the left header, but not the right header' do
      let(:predicate) { Function::Connective::Negation.new(left_header[:active_user]) }

      it 'does not partition the predicate to the left' do
        should be(Function::Proposition::Tautology.instance)
      end
    end

    context 'with an attribute from the right header, but not the left header' do
      let(:predicate) { Function::Connective::Negation.new(right_header[:active_employee]) }

      it 'partitions the predicate to the right' do
        should be(predicate)
      end
    end

    context 'with an attribute from the left and right header' do
      let(:predicate) { Function::Connective::Negation.new(right_header[:active]) }

      it 'partitions the predicate to the right' do
        should be(predicate)
      end
    end
  end

  context 'when the predicate is a conjunction' do
    let(:left_predicate)  { left_header[:user_name].eq('Dan Kubb')      }
    let(:right_predicate) { right_header[:employee_name].eq('Dan Kubb') }
    let(:predicate)       { left_predicate.and(right_predicate)         }

    it 'partitions the predicate to the right that reference the right header' do
      should be(right_predicate)
    end
  end

  context 'when the predicate is a disjunction' do
    let(:left_predicate)  { left_header[:user_name].eq('Dan Kubb')      }
    let(:right_predicate) { right_header[:employee_name].eq('Dan Kubb') }
    let(:predicate)       { left_predicate.or(right_predicate)          }

    it 'partitions the predicate to the right that reference the right header, transforming it with De Morgan\'s Law' do
      should eql(right_header[:employee_name].ne('Dan Kubb'))
    end
  end
end
