# encoding: utf-8

require 'spec_helper'

describe Relation::Operation::Insertion, '#optimize' do
  subject { object.optimize }

  let(:object)         { described_class.new(left, right) }
  let(:original_left)  { Relation.new(header, left_body)  }
  let(:original_right) { Relation.new(header, right_body) }
  let(:header)         { [ attribute ]                    }
  let(:attribute)      { Attribute::Integer.new(:id)      }
  let(:left_body)      { [ [ 1 ] ].each                   }
  let(:right_body)     { [ [ 2 ] ].each                   }

  context 'left is a rename relation' do
    let(:left)  { original_left.rename(:id => :other_id)  }
    let(:right) { original_right.rename(:id => :other_id) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == object
    end

    it 'does not execute left_body#each' do
      left_body.should_not_receive(:each)
      subject
    end

    it 'does not execute right_body#each' do
      right_body.should_not_receive(:each)
      subject
    end

    it { should be_instance_of(Algebra::Rename) }

    # check to make sure the insertion is pushed-down, and the right rename
    # is factored out (since the rename is inverted)
    its(:operand) { should eql(original_left.insert(original_right)) }

    it_should_behave_like 'an optimize method'
  end

  context 'left is a projection relation' do
    let(:left)          { original_left.project([ :id ])                                                                            }
    let(:right)         { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ].each)                                                        }
    let(:original_left) { Relation.new([ [ :id, Integer ], [ :name, String, { :required => false } ] ], [ [ 1, 'John Doe' ] ].each) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == object
    end

    it 'does not execute left_body#each' do
      left_body.should_not_receive(:each)
      subject
    end

    it 'does not execute right_body#each' do
      right_body.should_not_receive(:each)
      subject
    end

    it { should be_instance_of(Algebra::Projection) }

    it_should_behave_like 'an optimize method'
  end

  context 'left is an extension relation' do
    let(:left)  { original_left.extend  { |r| r.add(:name, 'John Doe') } }
    let(:right) { original_right.extend { |r| r.add(:name, 'John Doe') } }

    it 'does not push-down insertions' do
      should equal(object)
    end
  end

  context 'left is a summarization' do
    let(:left)  { original_left.summarize  { |r| r.add(:count, r.id.count) } }
    let(:right) { original_right.summarize { |r| r.add(:count, r.id.count) } }

    it 'does not push-down insertions' do
      should equal(object)
    end
  end

  context 'left is a join' do
    let(:left)       { left_left.join(left_right)                                                                           }
    let(:right)      { Relation.new([ [ :id, Integer ], [ :name, String ] ], [ [ 2, 'Jane Doe' ] ].each)                    }
    let(:left_left)  { Relation.new([ [ :id, Integer ]                    ], [ [ 1 ]                                ].each) }
    let(:left_right) { Relation.new([ [ :id, Integer ], [ :name, String ] ], [ [ 1, 'John Doe' ], [ 2, 'Jane Doe' ] ].each) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == object
    end

    it 'does not execute left_body#each' do
      left_body.should_not_receive(:each)
      subject
    end

    it 'does not execute right_body#each' do
      right_body.should_not_receive(:each)
      subject
    end

    it { should be_instance_of(Algebra::Join) }

    # check to make sure the insertion is pushed-down to the left and right
    # relations, and the right projection is factored out since the projected
    # attributes are the same as the header
    its(:left)  { should eql(left_left.insert(right.project([ :id ]))) }
    its(:right) { should eql(left_right.insert(right))                 }

    it_should_behave_like 'an optimize method'
  end

  context 'left is a product' do
    let(:left)       { left_left.product(left_right)                                                     }
    let(:right)      { Relation.new([ [ :id, Integer ], [ :name, String ] ], [ [ 2, 'Jane Doe' ] ].each) }
    let(:left_left)  { Relation.new([ [ :id,   Integer ] ], [ [ 1 ]          ].each)                     }
    let(:left_right) { Relation.new([ [ :name, String  ] ], [ [ 'John Doe' ] ].each)                     }

    it 'does not push-down insertions' do
      should equal(object)
    end
  end

  context 'left is an order relation' do
    let(:left)  { original_left.sort_by  { header } }
    let(:right) { original_right.sort_by { header } }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == object
    end

    it 'does not execute left_body#each' do
      left_body.should_not_receive(:each)
      subject
    end

    it 'does not execute right_body#each' do
      right_body.should_not_receive(:each)
      subject
    end

    it { should be_instance_of(Relation::Operation::Order) }

    # check to make sure the insertion is pushed-down
    its(:operand) { should eql(original_left.insert(original_right)) }

    its(:directions) { should == header }

    it_should_behave_like 'an optimize method'
  end

  context 'left is a reverse relation' do
    let(:left)  { original_left.sort_by  { header }.reverse }
    let(:right) { original_right.sort_by { header }.reverse }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == object
    end

    it 'does not execute left_body#each' do
      left_body.should_not_receive(:each)
      subject
    end

    it 'does not execute right_body#each' do
      right_body.should_not_receive(:each)
      subject
    end

    it { should be_instance_of(Relation::Operation::Order) }

    # check to make sure the insertion is pushed-down
    its(:operand) { should eql(original_left.insert(original_right)) }

    its(:directions) { should == [ attribute.desc ] }

    it_should_behave_like 'an optimize method'
  end

  context 'left is a limit relation' do
    let(:left)  { original_left.sort_by  { header }.take(1) }
    let(:right) { original_right.sort_by { header }.take(1) }

    it 'does not push-down insertions' do
      should equal(object)
    end
  end

  context 'left is an offset relation' do
    let(:left)  { original_left.sort_by  { header }.drop(1) }
    let(:right) { original_right.sort_by { header }.drop(1) }

    it 'does not push-down insertions' do
      should equal(object)
    end
  end
end
