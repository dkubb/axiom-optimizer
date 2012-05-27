# encoding: utf-8

require 'spec_helper'

describe Optimizer::Relation::Operation::Insertion::JoinLeft, '#optimize' do
  subject { object.optimize }

  let(:object)     { described_class.new(relation)                                                                        }
  let(:relation)   { left.insert(right)                                                                                   }
  let(:left)       { left_left.join(left_right)                                                                           }
  let(:right)      { Relation.new([ [ :id, Integer ], [ :name, String ] ], [ [ 2, 'Jane Doe' ] ].each)                    }
  let(:left_left)  { Relation.new([ [ :id, Integer ]                    ], [ [ 1 ]                                ].each) }
  let(:left_right) { Relation.new([ [ :id, Integer ], [ :name, String ] ], [ [ 1, 'John Doe' ], [ 2, 'Jane Doe' ] ].each) }

  before do
    object.should be_optimizable
  end

  it { should be_instance_of(Algebra::Join) }

  its(:left)  { should eql(left_left.insert(right.project([ :id ])))         }
  its(:right) { should eql(left_right.insert(right.project([ :id, :name ]))) }
end
