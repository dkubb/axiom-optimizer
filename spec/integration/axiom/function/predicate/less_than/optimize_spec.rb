# encoding: utf-8

require 'spec_helper'

describe Function::Predicate::LessThan, '#optimize' do
  subject { object.optimize }

  let(:attribute) { Attribute::Integer.new(:id, required: false, size: 1..2**31 - 1) }
  let(:left)      { attribute                                                        }
  let(:right)     { attribute                                                        }
  let(:object)    { described_class.new(left, right)                                 }

  context 'left and right are attributes' do
    context 'and equivalent' do
      it { should be(Function::Proposition::Contradiction.instance) }

      it_should_behave_like 'an optimize method'
    end

    context 'and are not comparable' do
      let(:right) { Attribute::Float.new(:float) }

      it { should be(Function::Proposition::Contradiction.instance) }

      it_should_behave_like 'an optimize method'
    end

    context 'and left is always less than right' do
      let(:left)  { attribute                                          }
      let(:right) { Attribute::Integer.new(:right, size: 2**31..2**31) }

      it { should be(Function::Proposition::Tautology.instance) }

      it_should_behave_like 'an optimize method'
    end

    context 'and left is always greater than or equal to right' do
      let(:left)  { attribute                                  }
      let(:right) { Attribute::Integer.new(:right, size: 0..0) }

      it { should be(Function::Proposition::Contradiction.instance) }

      it_should_behave_like 'an optimize method'
    end
  end

  context 'left is an attribute' do
    context 'right is a valid value' do
      let(:right) { 2 }

      it { should be(object) }

      it_should_behave_like 'an optimize method'
    end

    context 'right is an invalid primitive' do
      let(:right) { nil }

      it { should be(Function::Proposition::Contradiction.instance) }

      it_should_behave_like 'an optimize method'
    end
  end

  context 'right is an attribute' do
    context 'left is a valid value' do
      let(:left) { 1 }

      it { should eql(Function::Predicate::GreaterThan.new(attribute, 1)) }

      it_should_behave_like 'an optimize method'
    end

    context 'left is an invalid primitive' do
      let(:left) { nil }

      it { should be(Function::Proposition::Contradiction.instance) }

      it_should_behave_like 'an optimize method'
    end
  end

  context 'left and right are constants' do
    context 'that will evaluate to a tautology' do
      let(:left)  { 1 }
      let(:right) { 2 }

      it { should be(Function::Proposition::Tautology.instance) }

      it_should_behave_like 'an optimize method'
    end

    context 'that will evaluate to a contradiction' do
      let(:left)  { 1 }
      let(:right) { 1 }

      it { should be(Function::Proposition::Contradiction.instance) }

      it_should_behave_like 'an optimize method'
    end
  end
end
