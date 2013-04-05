# encoding: utf-8

require 'spec_helper'

describe Optimizer::Relation::Operation::Offset::UnoptimizedOperand, '#optimize' do
  subject { object.optimize }

  let(:header)   { Relation::Header.coerce([ [ :id, Integer ] ])                            }
  let(:order)    { Relation.new(header, LazyEnumerable.new([ [ 1 ] ])).sort_by { |r| r.id } }
  let(:relation) { order.rename({}).drop(1)                                                 }
  let(:object)   { described_class.new(relation)                                            }

  before do
    object.should be_optimizable
  end

  it { should be_kind_of(Relation::Operation::Offset) }

  its(:operand) { should equal(order) }

  its(:offset) { should == 1 }
end