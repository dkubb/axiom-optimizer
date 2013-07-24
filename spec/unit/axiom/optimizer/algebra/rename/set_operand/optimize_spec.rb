# encoding: utf-8

require 'spec_helper'

describe Optimizer::Algebra::Rename::SetOperand, '#optimize' do
  subject { object.optimize }

  let(:header)   { Relation::Header.coerce([[:id, Integer]])       }
  let(:left)     { Relation.new(header, LazyEnumerable.new([[1]])) }
  let(:right)    { Relation.new(header, LazyEnumerable.new([[2]])) }
  let(:relation) { left.union(right).rename(id: :other_id)         }
  let(:object)   { described_class.new(relation)                   }

  before do
    expect(object).to be_optimizable
  end

  it { should be_kind_of(Relation::Operation::Set) }

  its(:left) { should eql(left.rename(id: :other_id)) }

  its(:right) { should eql(right.rename(id: :other_id)) }
end
