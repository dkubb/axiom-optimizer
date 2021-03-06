# encoding: utf-8

require 'spec_helper'

describe Optimizer::Function::Connective::Disjunction::Tautology, '#optimizable?' do
  subject { object.optimizable? }

  let(:attribute)  { Attribute::Integer.new(:id)                        }
  let(:connective) { Function::Connective::Disjunction.new(left, right) }
  let(:object)     { described_class.new(connective)                    }

  before do
    expect(object.operation).to be_kind_of(Function::Connective::Disjunction)
  end

  context 'when left is a tautology' do
    let(:left)  { Function::Proposition::Tautology.instance }
    let(:right) { attribute.eq(1)                           }

    it { should be(true) }
  end

  context 'when right is a tautology' do
    let(:left)  { attribute.eq(1)                           }
    let(:right) { Function::Proposition::Tautology.instance }

    it { should be(true) }
  end

  context 'when left and right are inequality predicates with the same attribute and constant values' do
    let(:left)  { attribute.ne(1) }
    let(:right) { attribute.ne(2) }

    it { should be(true) }
  end

  context 'when left and right are inverses' do
    let(:left)  { attribute.eq(1) }
    let(:right) { attribute.ne(1) }

    it { should be(true) }
  end

  context 'when left and right are procs' do
    let(:left)  { proc {}  }
    let(:right) { proc {}  }

    it { should be(false) }
  end

  context 'when left is a proc' do
    let(:left)  { proc {}         }
    let(:right) { attribute.ne(1) }

    it { should be(false) }
  end

  context 'when right is a proc' do
    let(:left)  { attribute.eq(1) }
    let(:right) { proc {}         }

    it { should be(false) }
  end
end
