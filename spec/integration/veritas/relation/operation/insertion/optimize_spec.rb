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

    # check to make sure the insertion is pushed-down, and the right rename
    # is factored out (since it is a rename, then an inverted rename)
    its(:operand) { should eql(original_left.insert(original_right)) }

    it_should_behave_like 'an optimize method'
  end

  context 'left is a restriction relation' do
    let(:left)  { original_left.restrict { |r| r.id.eq(1) } }
    let(:right) { original_right                            }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == object
    end

    it 'does not execute left_body#each' do
      left_body.should_not_receive(:each)
      subject
    end

    it 'executes right_body#each' do
      right_body.should_receive(:each)
      subject
    end

    # check to make sure the insertion is pushed-down, and the right relation is
    # materialized, and the predicate matches tuples from the left and right
    its(:operand)   { should eql(original_left.insert(right.materialize)) }
    its(:predicate) { should eql(attribute.include([ 1, 2 ]))             }

    it_should_behave_like 'an optimize method'
  end

  context 'left is a projection relation' do
    let(:original_left) { Relation.new([ [ :id, Integer ], [ :name, String, { :required => false } ] ], [ [ 1, 'John Doe' ] ].each) }
    let(:left)          { original_left.project([ :id ])                                                                            }
    let(:right)         { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ].each)                                                        }

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

    it_should_behave_like 'an optimize method'
  end
end