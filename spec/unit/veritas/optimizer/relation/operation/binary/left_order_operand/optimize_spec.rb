# encoding: utf-8

require 'spec_helper'

describe Optimizer::Relation::Operation::Binary::LeftOrderOperand, '#optimize' do
  subject { object.optimize }

  let(:base)     { Relation.new([ [ :id, Integer ] ], [].each) }
  let(:left)     { base.sort_by { |r| r[:id] }                 }
  let(:right)    { base                                        }
  let(:relation) { left.union(right)                           }
  let(:object)   { described_class.new(relation)               }

  before do
    object.should be_optimizable
  end

  it { should be_kind_of(relation.class) }

  its(:left) { should equal(base) }

  its(:right) { should equal(right) }
end
