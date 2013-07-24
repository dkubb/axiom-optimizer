# encoding: utf-8

require 'spec_helper'

describe Optimizer::Algebra::Restriction::SetOperand, '#optimize' do
  subject { object.optimize }

  let(:header)    { Relation::Header.coerce([[:id, Integer]])       }
  let(:left)      { Relation.new(header, LazyEnumerable.new([[1]])) }
  let(:right)     { Relation.new(header, LazyEnumerable.new([[2]])) }
  let(:predicate) { header[:id].eq(1)                               }
  let(:relation)  { left.union(right).restrict { predicate }        }
  let(:object)    { described_class.new(relation)                   }

  before do
    expect(object).to be_optimizable
  end

  it { should be_kind_of(Relation::Operation::Set) }

  its(:left) { should eql(left.restrict { predicate }) }

  its(:right) { should eql(right.restrict { predicate }) }
end
