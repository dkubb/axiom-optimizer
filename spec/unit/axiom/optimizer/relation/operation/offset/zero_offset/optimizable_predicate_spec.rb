# encoding: utf-8

require 'spec_helper'

describe Optimizer::Relation::Operation::Offset::ZeroOffset, '#optimizable?' do
  subject { object.optimizable? }

  let(:base)     { Relation.new([ [ :id, Integer ] ], LazyEnumerable.new([ [ 1 ] ])).sort_by { |r| r.id } }
  let(:relation) { base.drop(offset)                                                                      }
  let(:object)   { described_class.new(relation)                                                          }

  before do
    expect(object.operation).to be_kind_of(Relation::Operation::Offset)
  end

  context 'when the operation offset is 0' do
    let(:offset) { 0 }

    it { should be(true) }
  end

  context 'when the operation offset is not 0' do
    let(:offset) { 1 }

    it { should be(false) }
  end
end
