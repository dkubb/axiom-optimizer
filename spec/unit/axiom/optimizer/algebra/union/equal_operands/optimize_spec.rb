# encoding: utf-8

require 'spec_helper'

describe Optimizer::Algebra::Union::EqualOperands, '#optimize' do
  subject { object.optimize }

  let(:header)   { Relation::Header.coerce([[:id, Integer]])       }
  let(:left)     { Relation.new(header, LazyEnumerable.new([[1]])) }
  let(:right)    { Relation.new(header, LazyEnumerable.new([[1]])) }
  let(:relation) { left.union(right)                               }
  let(:object)   { described_class.new(relation)                   }

  before do
    expect(object).to be_optimizable
  end

  it { should be(left) }
end
