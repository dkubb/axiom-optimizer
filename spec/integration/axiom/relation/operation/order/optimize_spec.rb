# encoding: utf-8

require 'spec_helper'

describe Relation::Operation::Order, '#optimize' do
  subject { object.optimize }

  let(:body)       { LazyEnumerable.new([[1], [2], [3]])      }
  let(:relation)   { Relation.new([[:id, Integer]], body)     }
  let(:operand)    { relation                                 }
  let(:directions) { [relation[:id]]                          }
  let(:object)     { described_class.new(operand, directions) }

  context 'containing a relation' do
    it { should be(object) }

    it 'does not execute body#each' do
      expect(body).not_to receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'containing an optimizable relation' do
    let(:operand) { relation.project(relation.header) }

    it { should eql(relation.sort_by { directions }) }

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
    let(:operand) { relation.sort_by { |r| [r.id.desc] } }

    it { should eql(relation.sort_by { directions }) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == object
    end

    it 'does not execute body#each' do
      expect(body).not_to receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'containing a reverse operation' do
    let(:operand) { relation.sort_by { |r| r.id }.reverse }

    it { should eql(relation.sort_by { |r| r.id }) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == object
    end

    it 'does not execute body#each' do
      expect(body).not_to receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'containing a limit(1) operation' do
    let(:operand) { relation.sort_by { |r| r.id }.take(1) }

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
    let(:object)   { described_class.new(relation, directions)       }

    it { should eql(Relation::Materialized.new([[:id, Integer]], [[1], [2], [3]])) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == object
    end

    it_should_behave_like 'an optimize method'
  end
end
