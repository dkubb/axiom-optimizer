# encoding: utf-8

require 'spec_helper'

describe Optimizer::Relation::Operation::Insertion::RenameLeft, '#optimizable?' do
  subject { object.optimizable? }

  let(:object)    { described_class.new(relation)              }
  let(:relation)  { left.insert(right)                         }
  let(:base_left) { Relation.new(header, [ [ 1 ] ].each)       }
  let(:header)    { Relation::Header.new([ [ :id, Integer ] ]) }

  before do
    object.operation.should be_kind_of(Relation::Operation::Insertion)
  end

  context 'when the left is a rename' do
    let(:left)  { base_left.rename(:id => :other_id)                       }
    let(:right) { Relation.new([ [ :other_id, Integer ] ], [ [ 2 ] ].each) }

    it { should be(true) }
  end

  context 'when the left is not a rename' do
    let(:left)  { base_left                            }
    let(:right) { Relation.new(header, [ [ 2 ] ].each) }

    it { should be(false) }
  end
end
