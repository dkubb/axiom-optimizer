# encoding: utf-8

require 'spec_helper'

describe Optimizer::Relation::Operation::Insertion::ProjectionLeft, '#optimize' do
  subject { object.optimize }

  let(:object)    { described_class.new(relation)                                   }
  let(:relation)  { left.insert(right)                                              }
  let(:base_left) { Relation.new(header, [ [ 1, 'John Doe' ] ].each)                }
  let(:left)      { base_left.project([ :id ])                                      }
  let(:right)     { Relation.new([ [ :id, Integer ] ], [ [ 2 ] ].each)              }
  let(:header)    { [ [ :id, Integer ], [ :name, String, { :required => false } ] ] }

  before do
    object.should be_optimizable
  end

  it { should be_instance_of(Algebra::Projection) }

  # the operand is the base left and the right is extended with the removed attributes
  its(:operand) do
    should eql(base_left.insert(right.extend { |r|
      r.add([ :name, String, { :required => false } ], nil)
    }))
  end

  its(:header) { should == [ [ :id, Integer ] ] }
end
