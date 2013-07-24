# encoding: utf-8

require 'spec_helper'

describe Optimizer::Algebra::Difference::EmptyRight, '#optimize' do
  subject { object.optimize }

  let(:header)   { Relation::Header.coerce([ [ :id, Integer ] ])       }
  let(:left)     { Relation.new(header, LazyEnumerable.new([ [ 1 ] ])) }
  let(:right)    { Relation::Empty.new(header)                         }
  let(:relation) { left.difference(right)                              }
  let(:object)   { described_class.new(relation)                       }

  before do
    expect(object).to be_optimizable
  end

  it { should be(left) }
end
