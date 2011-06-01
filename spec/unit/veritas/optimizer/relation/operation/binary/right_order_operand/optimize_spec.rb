# encoding: utf-8

require 'spec_helper'

describe Optimizer::Relation::Operation::Binary::RightOrderOperand, '#optimize' do
  subject { object.optimize }

  let(:base)     { Relation.new([ [ :id, Integer ] ], [].each) }
  let(:left)     { base                                        }
  let(:right)    { base.order                                  }
  let(:relation) { left.union(right)                           }
  let(:object)   { described_class.new(relation)               }

  before do
    object.should be_optimizable
  end

  it { should be_kind_of(relation.class) }

  its(:left) { should equal(left) }

  its(:right) { should equal(base) }
end