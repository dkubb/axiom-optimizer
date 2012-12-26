# encoding: utf-8

require 'spec_helper'

describe Optimizer::Algebra::Difference::EqualOperands, '#optimize' do
  subject { object.optimize }

  let(:header)   { Relation::Header.coerce([ [ :id, Integer ] ])       }
  let(:left)     { Relation.new(header, LazyEnumerable.new([ [ 1 ] ])) }
  let(:right)    { Relation.new(header, LazyEnumerable.new([ [ 1 ] ])) }
  let(:relation) { left.difference(right)                              }
  let(:object)   { described_class.new(relation)                       }

  before do
    object.should be_optimizable
  end

  it { should be_kind_of(Relation::Empty) }

  its(:header) { should equal(header) }

  its(:tuples) { should equal(relation) }
end
