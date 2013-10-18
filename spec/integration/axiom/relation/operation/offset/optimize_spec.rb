# encoding: utf-8

require 'spec_helper'

describe Relation::Operation::Offset, '#optimize' do
  subject { object.optimize }

  let(:body)       { LazyEnumerable.new([[1], [2], [3]])  }
  let(:relation)   { Relation.new([[:id, Integer]], body) }
  let(:directions) { [relation[:id]]                      }
  let(:sorted)     { relation.sort_by { directions }      }
  let(:operand)    { sorted                               }
  let(:offset)     { 1                                    }
  let(:object)     { described_class.new(operand, offset) }

  context 'with an object of 0' do
    let(:offset) { 0 }

    it { should be(sorted) }

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

    its(:offset) { should == 1 }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == object
    end

    it 'does not execute body#each' do
      expect(body).not_to receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'containing an object operation' do
    let(:operand) { sorted.drop(5) }
    let(:offset)  { 10             }

    it { should be_kind_of(described_class) }

    its(:operand) { should be(sorted) }

    it 'adds the object of the operations' do
      expect(subject.offset).to be(15)
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

  context 'containing a materialized relation' do
    let(:relation) { Relation.new([[:id, Integer]], [[1], [2], [3]]) }

    it { should eql(Relation::Materialized.new([[:id, Integer]], [[2], [3]])) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == object
    end

    it_should_behave_like 'an optimize method'
  end
end
