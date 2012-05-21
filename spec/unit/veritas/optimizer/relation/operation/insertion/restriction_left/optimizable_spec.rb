# encoding: utf-8

require 'spec_helper'

describe Optimizer::Relation::Operation::Insertion::RestrictionLeft, '#optimizable?' do
  subject { object.optimizable? }

  let(:object)    { described_class.new(relation)              }
  let(:relation)  { left.insert(right)                         }
  let(:base_left) { Relation.new(header, [ [ 1 ] ].each)       }
  let(:right)     { Relation.new(header, [ [ 2 ] ].each)       }
  let(:header)    { Relation::Header.new([ [ :id, Integer ] ]) }

  before do
    object.operation.should be_kind_of(Relation::Operation::Insertion)
  end

  context 'when the left is a restriction' do
    let(:left) { base_left.restrict { |r| r.id.eq(1) } }

    it { should be(true) }
  end

  context 'when the left is not a rename' do
    let(:left) { base_left }

    it { should be(false) }
  end
end
