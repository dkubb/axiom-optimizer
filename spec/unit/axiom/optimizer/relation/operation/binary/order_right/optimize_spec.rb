# encoding: utf-8

require 'spec_helper'

describe Optimizer::Relation::Operation::Binary::OrderRight, '#optimize' do
  subject { object.optimize }

  let(:base)     { Relation.new([ [ :id, Integer ] ], LazyEnumerable.new) }
  let(:left)     { base                                                   }
  let(:right)    { base.sort_by { |r| r.id }                              }
  let(:relation) { left.union(right)                                      }
  let(:object)   { described_class.new(relation)                          }

  before do
    object.should be_optimizable
  end

  it { should be_kind_of(relation.class) }

  its(:left) { should equal(left) }

  its(:right) { should equal(base) }
end
