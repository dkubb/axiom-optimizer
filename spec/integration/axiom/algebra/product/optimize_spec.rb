# encoding: utf-8

require 'spec_helper'

describe Algebra::Product, '#optimize' do
  subject { object.optimize }

  let(:left_body)  { LazyEnumerable.new([ [ 1 ] ])                    }
  let(:right_body) { LazyEnumerable.new([ [ 'Dan Kubb' ] ])           }
  let(:left)       { Relation.new([ [ :id,   Integer ] ], left_body)  }
  let(:right)      { Relation.new([ [ :name, String  ] ], right_body) }
  let(:object)     { described_class.new(left, right)                 }

  context 'left is a TABLE_DUM' do
    let(:left) { TABLE_DUM }

    it { should eql(Relation::Empty.new(right.header)) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == object
    end

    it 'does not execute right_body#each' do
      right_body.should_not_receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'right is a TABLE_DUM' do
    let(:right) { TABLE_DUM }

    it { should eql(Relation::Empty.new(left.header)) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == object
    end

    it 'does not execute left_body#each' do
      left_body.should_not_receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'left is a TABLE_DUM when optimized' do
    let(:left) { TABLE_DUM.project([]) }

    it { should eql(Relation::Empty.new(right.header)) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == object
    end

    it 'does not execute right_body#each' do
      right_body.should_not_receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'right is a TABLE_DUM when optimized' do
    let(:right) { TABLE_DUM.project([]) }

    it { should eql(Relation::Empty.new(left.header)) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == object
    end

    it 'does not execute left_body#each' do
      left_body.should_not_receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'left is a TABLE_DEE' do
    let(:left) { TABLE_DEE }

    it { should be(right) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == object
    end

    it 'does not execute right_body#each' do
      right_body.should_not_receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'right is a TABLE_DEE' do
    let(:right) { TABLE_DEE }

    it { should be(left) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == object
    end

    it 'does not execute left_body#each' do
      left_body.should_not_receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'left is a TABLE_DEE when optimized' do
    let(:left) { TABLE_DEE.project([]) }

    it { should be(right) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == object
    end

    it 'does not execute right_body#each' do
      right_body.should_not_receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'right is a TABLE_DEE when optimized' do
    let(:right) { TABLE_DEE.project([]) }

    it { should be(left) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == object
    end

    it 'does not execute left_body#each' do
      left_body.should_not_receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'left and right are normal relations' do
    it { should be(object) }

    it 'does not execute left_body#each' do
      left_body.should_not_receive(:each)
      subject
    end

    it 'does not execute right_body#each' do
      right_body.should_not_receive(:each)
      subject
    end

    it_should_behave_like 'an optimize method'
  end

  context 'left and right are materialized relations' do
    let(:left)  { Relation.new([ [ :id,   Integer ] ], [ [ 1 ] ])          }
    let(:right) { Relation.new([ [ :name, String  ] ], [ [ 'Dan Kubb' ] ]) }

    it { should eql(Relation::Materialized.new([ [ :id, Integer ], [ :name, String ] ], [ [ 1, 'Dan Kubb' ] ])) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == object
    end

    it_should_behave_like 'an optimize method'
  end
end
