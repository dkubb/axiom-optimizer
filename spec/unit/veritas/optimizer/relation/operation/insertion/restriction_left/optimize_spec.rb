# encoding: utf-8

require 'spec_helper'

describe Optimizer::Relation::Operation::Insertion::RestrictionLeft, '#optimize' do
  subject { object.optimize }

  let(:object)    { described_class.new(relation)         }
  let(:relation)  { left.insert(right)                    }
  let(:base_left) { Relation.new(header, [ [ 1 ] ].each)  }
  let(:left)      { base_left.restrict { |r| r.id.eq(1) } }
  let(:right)     { Relation.new(header, [ [ 2 ] ].each)  }
  let(:header)    { Relation::Header.new([ attribute ])   }
  let(:attribute) { Attribute::Integer.new(:id)           }

  before do
    object.should be_optimizable
  end

  it { should be_instance_of(Algebra::Restriction) }

  # the operand is unwrapped from the left, and right is materialized
  its(:operand) { should eql(base_left.insert(right.materialize)) }

  # the predicate is a disjunction of the original and each tuple predicate
  its(:predicate) { should eql(attribute.eq(1).or(attribute.eq(2))) }
end
