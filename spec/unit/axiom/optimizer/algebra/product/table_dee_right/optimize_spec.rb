# encoding: utf-8

require 'spec_helper'

describe Optimizer::Algebra::Product::TableDeeRight, '#optimize' do
  subject { object.optimize }

  let(:left)     { Relation.new([[:id, Integer]], LazyEnumerable.new([[1]])) }
  let(:right)    { TABLE_DEE                                                 }
  let(:relation) { left.product(right)                                       }
  let(:object)   { described_class.new(relation)                             }

  before do
    expect(object).to be_optimizable
  end

  it { should be(left) }
end
