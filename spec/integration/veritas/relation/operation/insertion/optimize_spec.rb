# encoding: utf-8

require 'spec_helper'

describe Relation::Operation::Insertion, '#optimize' do
  subject { object.optimize }

  let(:object)         { described_class.new(left, right) }
  let(:original_left)  { Relation.new(header, left_body)  }
  let(:original_right) { Relation.new(header, right_body) }
  let(:header)         { [ [ :id, Integer ] ]             }
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

    its(:operand) { should eql(original_left.insert(original_right)) }

    it_should_behave_like 'an optimize method'
  end
end
