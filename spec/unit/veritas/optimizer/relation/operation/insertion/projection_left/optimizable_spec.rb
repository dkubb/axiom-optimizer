# encoding: utf-8

require 'spec_helper'

describe Optimizer::Relation::Operation::Insertion::ProjectionLeft, '#optimizable?' do
  subject { object.optimizable? }

  let(:object)   { described_class.new(relation)                      }
  let(:relation) { left.insert(right)                                 }
  let(:right)    { Relation.new([ [ :id, Integer ] ], [ [ 2 ] ].each) }

  before do
    object.operation.should be_kind_of(Relation::Operation::Insertion)
  end

  context 'when the left is a projection, and removed attributes are optional' do
    let(:header) { [ [ :id, Integer ], [ :name, String, { :required => false } ] ]   }
    let(:left)   { Relation.new(header, [ [ 1, 'John Doe' ] ].each).project([ :id ]) }

    it { should be(true) }
  end

  context 'when the left is a projection, and removed attributes are required' do
    let(:header) { [ [ :id, Integer ], [ :name, String ] ]                           }
    let(:left)   { Relation.new(header, [ [ 1, 'John Doe' ] ].each).project([ :id ]) }

    it { should be(false) }
  end

  context 'when the left is not a projection' do
    let(:left) { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ].each) }

    it { should be(false) }
  end
end
