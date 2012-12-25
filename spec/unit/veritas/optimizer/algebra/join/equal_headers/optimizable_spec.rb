# encoding: utf-8

require 'spec_helper'

describe Optimizer::Algebra::Join::EqualHeaders, '#optimizable?' do
  subject { object.optimizable? }

  let(:relation) { left.join(right)              }
  let(:object)   { described_class.new(relation) }

  before do
    object.operation.should be_kind_of(Algebra::Join)
  end

  context 'when left and right headers are equal' do
    let(:header) { Relation::Header.coerce([ [ :id, Integer ] ]) }
    let(:left)   { Relation.new(header, [ [ 1 ] ].each)          }
    let(:right)  { Relation.new(header, [ [ 1 ] ].each)          }

    it { should be(true) }
  end

  context 'when left and right headers are not equal' do
    let(:left)  { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ].each)                                 }
    let(:right) { Relation.new([ [ :id, Integer ], [ :name, String  ] ], [ [ 1, 'Dan Kubb' ] ].each) }

    it { should be(false) }
  end
end
