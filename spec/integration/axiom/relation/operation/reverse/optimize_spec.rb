# encoding: utf-8

require 'spec_helper'

describe Relation::Operation::Reverse, '#optimize' do
  subject { object.optimize }

  let(:body)     { LazyEnumerable.new([[1], [2], [3]])  }
  let(:relation) { Relation.new([[:id, Integer]], body) }
  let(:sorted)   { relation.sort_by { |r| r.id }        }
  let(:operand)  { sorted                               }
  let(:object)   { described_class.new(operand)         }

  context 'with a object operation' do
    let(:limit)   { sorted.take(2) }
    let(:operand) { limit.reverse  }

    it 'cancels out the operations and return the contained operation' do
      should be(limit)
    end

    it 'returns an equivalent relation to the unoptimized operation' do
      should == object
    end

    it 'does not execute body#each' do
      expect(body).not_to receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'with a object operation when optimized' do
    let(:limit)   { sorted.take(2)           }
    let(:operand) { limit.reverse.rename({}) }

    it 'cancels out the operations and return the contained operation' do
      should be(limit)
    end

    it 'returns an equivalent relation to the unoptimized operation' do
      should == object
    end

    it 'does not execute body#each' do
      expect(body).not_to receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'with a sorted operation' do
    it { should eql(relation.sort_by { object.directions }) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == object
    end

    it 'does not execute body#each' do
      expect(body).not_to receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'with a sorted operation when optimized' do
    let(:operand) { sorted.rename({}) }

    it { should eql(relation.sort_by { object.directions }) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == object
    end

    it 'does not execute body#each' do
      expect(body).not_to receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'with an optimizable operation' do
    let(:limit)   { sorted.take(2)   }
    let(:operand) { limit.rename({}) }

    it { should eql(sorted.take(2).reverse) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == object
    end

    it 'does not execute body#each' do
      expect(body).not_to receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'containing a materialized relation' do
    let(:relation) { Relation.new([[:id, Integer]], [[1], [2], [3]]) }

    it { should eql(Relation::Materialized.new([[:id, Integer]], [[3], [2], [1]])) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == object
    end

    it_should_behave_like 'an optimize method'
  end
end
