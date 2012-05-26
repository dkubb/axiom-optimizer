# encoding: utf-8

require 'spec_helper'

describe Optimizer::Relation::Operation::Insertion::OrderLeft, '#optimize' do
  subject { object.optimize }

  let(:object)     { described_class.new(relation)         }
  let(:relation)   { left.insert(right)                    }
  let(:left)       { base_left.sort_by  { header }         }
  let(:right)      { base_right.sort_by { header }         }
  let(:base_left)  { Relation.new(header, [ [ 1 ] ].each)  }
  let(:base_right) { Relation.new(header, [ [ 2 ] ].each)  }
  let(:header)     { Relation::Header.new([ attribute ])   }
  let(:attribute)  { Attribute::Integer.new(:id)           }

  before do
    object.should be_optimizable
  end

  it { should be_instance_of(Relation::Operation::Order) }

  # the operand is unwrapped from the left and right
  its(:operand) { should eql(base_left.insert(base_right)) }

  # the directions are used from the left operand
  its(:directions) { should == header }
end
