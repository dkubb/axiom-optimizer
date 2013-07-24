# encoding: utf-8

require 'spec_helper'

describe Optimizer::Relation::Operation::Binary::OrderLeft, '#optimize' do
  subject { object.optimize }

  let(:base)     { Relation.new([ [ :id, Integer ] ], LazyEnumerable.new) }
  let(:left)     { base.sort_by { |r| r.id }                              }
  let(:right)    { base                                                   }
  let(:relation) { left.union(right)                                      }
  let(:object)   { described_class.new(relation)                          }

  before do
    expect(object).to be_optimizable
  end

  it { should be_kind_of(relation.class) }

  its(:left) { should be(base) }

  its(:right) { should be(right) }
end
