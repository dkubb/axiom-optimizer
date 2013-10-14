# encoding: utf-8

require 'spec_helper'

describe Algebra::Union, '#optimize' do
  subject { object.optimize }

  let(:header)         { [[:id, Integer]]                 }
  let(:left_body)      { LazyEnumerable.new([[1]])        }
  let(:right_body)     { LazyEnumerable.new([[2]])        }
  let(:original_left)  { Relation.new(header, left_body)  }
  let(:original_right) { Relation.new(header, right_body) }
  let(:object)         { described_class.new(left, right) }

  before do
    # skip dup of the left and right body to avoid clearing the method stubs
    allow(left_body).to receive(:frozen?).and_return(true)
    allow(right_body).to receive(:frozen?).and_return(true)
  end

  context 'left is an empty relation' do
    let(:left)  { Relation::Empty.new(header) }
    let(:right) { original_right              }

    it { should be(right) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == object
    end

    it 'does not execute left_body#each' do
      expect(left_body).not_to receive(:each)
      subject
    end

    it 'does not execute right_body#each' do
      expect(right_body).not_to receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'right is an empty relation' do
    let(:left)  { original_left               }
    let(:right) { Relation::Empty.new(header) }

    it { should be(left) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == object
    end

    it 'does not execute left_body#each' do
      expect(left_body).not_to receive(:each)
      subject
    end

    it 'does not execute right_body#each' do
      expect(right_body).not_to receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'left is an empty relation when optimized' do
    let(:left)  { Algebra::Restriction.new(original_left, Function::Proposition::Contradiction.instance) }
    let(:right) { original_right                                                                         }

    it { should be(right) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == object
    end

    it 'does not execute left_body#each' do
      expect(left_body).not_to receive(:each)
      subject
    end

    it 'does not execute right_body#each' do
      expect(right_body).not_to receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'right is an empty relation when optimized' do
    let(:left)  { original_left                                                                           }
    let(:right) { Algebra::Restriction.new(original_right, Function::Proposition::Contradiction.instance) }

    it { should be(left) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == object
    end

    it 'does not execute left_body#each' do
      expect(left_body).not_to receive(:each)
      subject
    end

    it 'does not execute right_body#each' do
      expect(right_body).not_to receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'left and right are equivalent relations' do
    let(:left_body)  { LazyEnumerable.new([[1]]) }
    let(:right_body) { LazyEnumerable.new([[1]]) }
    let(:left)       { original_left             }
    let(:right)      { original_right            }

    it { should be(left) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == object
    end

    it 'does not execute left_body#each' do
      pending 'TODO: should only compare left and right with #eql? if they are materialized' do
        left_body.should_not_receive(:each)
        subject
      end
    end

    it 'does not execute right_body#each' do
      pending 'TODO: should only compare left and right with #eql? if they are materialized' do
        right_body.should_not_receive(:each)
        subject
      end
    end

    it_should_behave_like 'an optimize method'
  end

  context 'left and right are equivalent materialized relations' do
    let(:left_body)  { [[1]]          }
    let(:right_body) { [[1]]          }
    let(:left)       { original_left  }
    let(:right)      { original_right }

    it { should be(left) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == object
    end

    it 'executes left_body#each' do
      pending 'only receive #each once'
      expect(left_body).to receive(:each)
      subject
    end

    it 'executes right_body#each' do
      pending 'only receive #each once'
      expect(right_body).to receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'left and right are not empty relations' do
    let(:left)  { original_left  }
    let(:right) { original_right }

    it { should be(object) }

    it 'executes left_body#each' do
      expect(left_body).to receive(:each)
      subject
    end

    it 'executes right_body#each' do
      expect(right_body).to receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'left and right are materialized relations' do
    let(:left)  { Relation.new(header, [[1], [2]]) }
    let(:right) { Relation.new(header, [[1]])      }

    it { should eql(Relation::Materialized.new(header, [[1], [2]])) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == object
    end

    it_should_behave_like 'an optimize method'
  end
end
