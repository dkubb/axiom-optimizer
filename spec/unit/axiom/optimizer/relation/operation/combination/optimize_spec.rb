# encoding: utf-8

require 'spec_helper'

describe Optimizer::Relation::Operation::Combination, '#optimize' do
  subject { object.optimize }

  let(:left)     { Relation.new([[:id, Integer]], []) }
  let(:right)    { Relation.new([[:id, Integer]], []) }
  let(:relation) { left.join(right)                   }
  let(:object)   { described_class.new(relation)      }

  it { should be_kind_of(Relation::Empty) }

  its(:header) { should be(relation.header) }
end
