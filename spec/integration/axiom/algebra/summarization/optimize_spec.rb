# encoding: utf-8

require 'spec_helper'

describe Algebra::Summarization, '#optimize' do
  subject { object.optimize }

  let(:header)        { [[:id, Integer], [:name, String], [:age, Integer]]              }
  let(:body)          { LazyEnumerable.new([[1, 'Dan Kubb', 35], [2, 'Jane Doe', 24]])  }
  let(:relation)      { Relation.new(header, body)                                      }
  let(:operand)       { relation                                                        }
  let(:summarize_per) { relation.project([:id])                                         }
  let(:summarizers)   { { Attribute.coerce(:count) => ->(acc, tuple) { acc.to_i + 1 } } }
  let(:object)        { described_class.new(operand, summarize_per, summarizers)        }

  context 'when the operand is empty' do
    let(:operand) { relation.restrict { false } }

    it { should eql(summarize_per.extend { |r| r.add(:count, nil) }) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == object
    end

    it 'does not execute body#each' do
      expect(body).not_to receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'when the summarize_per is empty' do
    let(:summarize_per) { relation.project([:id]).restrict { false } }

    it { should eql(Relation::Empty.new(object.header)) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == object
    end

    it 'does not execute body#each' do
      expect(body).not_to receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end
end
