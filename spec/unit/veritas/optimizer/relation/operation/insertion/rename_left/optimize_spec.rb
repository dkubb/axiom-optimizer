# encoding: utf-8

require 'spec_helper'

describe Optimizer::Relation::Operation::Insertion::RenameLeft, '#optimize' do
  subject { object.optimize }

  let(:object)     { described_class.new(relation)                            }
  let(:relation)   { left.insert(right)                                       }
  let(:base_left)  { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ].each)       }
  let(:left)       { base_left.rename(aliases)                                }
  let(:right)      { Relation.new([ [ :other_id, Integer ] ], [ [ 2 ] ].each) }
  let(:aliases)    { { :id => :other_id }                                     }

  before do
    object.should be_optimizable
  end

  it { should be_instance_of(Algebra::Rename) }

  it { should == Relation.new([ [ :other_id, Integer ] ], [ [ 1 ], [ 2 ] ]) }

  its(:operand) { should be_instance_of(Relation::Operation::Insertion) }

  # the operand is unwrapped from the left, and right becomes an inverted rename
  its(:operand) { should eql(base_left.insert(right.rename(aliases.invert))) }
end
