# encoding: utf-8

require 'spec_helper'

describe Relation::Operation::Limit, '#optimize' do
  subject { object.optimize }

  let(:body)       { LazyEnumerable.new([[1], [2], [3]])  }
  let(:relation)   { Relation.new([[:id, Integer]], body) }
  let(:directions) { [relation[:id]]                      }
  let(:sorted)     { relation.sort_by { directions }      }
  let(:operand)    { sorted                               }
  let(:limit)      { 1                                    }
  let(:object)     { described_class.new(operand, limit)  }

  context 'when the limit is 0' do
    let(:limit) { 0 }

    it { should be_kind_of(Relation::Empty) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == object
    end

    it 'does not execute body#each' do
      expect(body).not_to receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'containing a sorted operation' do
    it { should be(object) }

    it 'does not execute body#each' do
      expect(body).not_to receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'containing an optimizable sorted operation' do
    let(:operand) { sorted.rename({}) }

    it { should be_kind_of(described_class) }

    its(:operand) { should be(sorted) }

    its(:limit) { should == 1 }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == object
    end

    it 'does not execute body#each' do
      expect(body).not_to receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'containing a more restrictive object operation' do
    let(:operand) { sorted.take(5) }
    let(:limit)   { 10             }

    it { should be_kind_of(described_class) }

    its(:operand) { should be(sorted) }

    it 'uses the more restrictive object' do
      expect(subject.limit).to be(5)
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

  context 'containing a less restrictive object operation' do
    let(:operand) { sorted.take(10) }
    let(:limit)   { 5               }

    it { should be_kind_of(described_class) }

    its(:operand) { should be(sorted) }

    it 'uses the more restrictive object' do
      expect(subject.limit).to be(5)
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

  context 'containing a similar object operation' do
    let(:operand) { sorted.take(10) }
    let(:limit)   { 10              }

    it { should be(operand) }

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

    it { should eql(Relation::Materialized.new([[:id, Integer]], [[1]])) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == object
    end

    it_should_behave_like 'an optimize method'
  end
end
