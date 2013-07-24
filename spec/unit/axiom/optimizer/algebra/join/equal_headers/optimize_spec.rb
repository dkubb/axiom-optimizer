# encoding: utf-8

require 'spec_helper'

describe Optimizer::Algebra::Join::EqualHeaders, '#optimize' do
  subject { object.optimize }

  let(:header)   { Relation::Header.coerce([[:id, Integer]])       }
  let(:left)     { Relation.new(header, LazyEnumerable.new([[1]])) }
  let(:right)    { Relation.new(header, LazyEnumerable.new([[2]])) }
  let(:relation) { left.join(right)                                }
  let(:object)   { described_class.new(relation)                   }

  before do
    expect(object).to be_optimizable
  end

  it { should be_kind_of(Algebra::Intersection) }

  its(:left) { should be(left) }

  its(:right) { should be(right) }
end
