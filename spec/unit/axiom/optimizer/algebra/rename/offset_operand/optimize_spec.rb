# encoding: utf-8

require 'spec_helper'

describe Optimizer::Algebra::Rename::OffsetOperand, '#optimize' do
  subject { object.optimize }

  let(:header)   { Relation::Header.coerce([ [ :id, Integer ] ])       }
  let(:base)     { Relation.new(header, LazyEnumerable.new([ [ 1 ] ])) }
  let(:order)    { base.sort_by { |r| r.id }                           }
  let(:relation) { order.drop(1).rename(:id => :other_id)              }
  let(:object)   { described_class.new(relation)                       }

  before do
    expect(object).to be_optimizable
  end

  it { should be_kind_of(Relation::Operation::Offset) }

  its(:operand) { should eql(order.rename(:id => :other_id)) }

  its(:offset) { should == 1 }
end
