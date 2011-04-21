require 'spec_helper'

describe Logic::Predicate::Equality, '#optimize' do
  subject { object.optimize }

  let(:attribute) { Attribute::Integer.new(:id)      }
  let(:left)      { attribute                        }
  let(:right)     { attribute                        }
  let(:object)    { described_class.new(left, right) }

  context 'left and right are attributes' do
    context 'and equivalent' do
      it { should equal(Logic::Proposition::Tautology.instance) }

      it_should_behave_like 'an optimize method'
    end

    context 'and are not joinable' do
      let(:right) { Attribute::String.new(:other) }

      it { should equal(Logic::Proposition::Contradiction.instance) }

      it_should_behave_like 'an optimize method'
    end

    context 'and are joinable' do
      let(:right) { Attribute::Numeric.new(:other) }

      it { should equal(object) }

      it_should_behave_like 'an optimize method'
    end
  end

  context 'left is an attribute' do
    context 'right is a valid value' do
      let(:right) { 1 }

      it { should equal(object) }

      it_should_behave_like 'an optimize method'
    end

    context 'right is an invalid value' do
      let(:right) { 'a' }

      it { should equal(Logic::Proposition::Contradiction.instance) }

      it_should_behave_like 'an optimize method'
    end
  end

  context 'right is an attribute' do
    context 'left is a valid value' do
      let(:left) { 1 }

      it { should eql(described_class.new(attribute, 1)) }

      it_should_behave_like 'an optimize method'
    end

    context 'left is an invalid value' do
      let(:left) { 'a' }

      it { should equal(Logic::Proposition::Contradiction.instance) }

      it_should_behave_like 'an optimize method'
    end
  end

  context 'left and right are constants' do
    context 'that will evaluate to a tautology' do
      let(:left)  { 1 }
      let(:right) { 1 }

      it { should equal(Logic::Proposition::Tautology.instance) }

      it_should_behave_like 'an optimize method'
    end

    context 'that will evaluate to a contradiction' do
      let(:left)  { 1 }
      let(:right) { 2 }

      it { should equal(Logic::Proposition::Contradiction.instance) }

      it_should_behave_like 'an optimize method'
    end
  end
end
