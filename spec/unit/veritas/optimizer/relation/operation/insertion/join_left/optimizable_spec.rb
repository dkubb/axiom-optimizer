# encoding: utf-8

require 'spec_helper'

describe Optimizer::Relation::Operation::Insertion::JoinLeft, '#optimizable?' do
  subject { object.optimizable? }

  let(:object)     { described_class.new(relation)                                                                        }
  let(:relation)   { left.insert(right)                                                                                   }
  let(:right)      { Relation.new([ [ :id, Integer ], [ :name, String ] ], [ [ 2, 'Jane Doe' ] ].each)                    }
  let(:left_left)  { Relation.new([ [ :id, Integer ]                    ], [ [ 1 ]                                ].each) }
  let(:left_right) { Relation.new([ [ :id, Integer ], [ :name, String ] ], [ [ 1, 'John Doe' ], [ 2, 'Jane Doe' ] ].each) }

  before do
    object.operation.should be_kind_of(Relation::Operation::Insertion)
  end

  context 'when the left is a join' do
    let(:left) { left_left.join(left_right) }

    it { should be(true) }
  end

  context 'when the left is not a join' do
    let(:left) { left_right }

    it { should be(false) }
  end
end
