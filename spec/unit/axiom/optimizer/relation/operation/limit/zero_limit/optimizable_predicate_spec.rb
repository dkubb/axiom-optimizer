# encoding: utf-8

require 'spec_helper'

describe Optimizer::Relation::Operation::Limit::ZeroLimit, '#optimizable?' do
  subject { object.optimizable? }

  let(:base)     { Relation.new([ [ :id, Integer ] ], LazyEnumerable.new([ [ 1 ] ])).sort_by { |r| r.id } }
  let(:relation) { base.take(limit)                                                                       }
  let(:object)   { described_class.new(relation)                                                          }

  before do
    expect(object.operation).to be_kind_of(Relation::Operation::Limit)
  end

  context 'when the operation limit is 0' do
    let(:limit) { 0 }

    it { should be(true) }
  end

  context 'when the operation limit is not 0' do
    let(:limit) { 1 }

    it { should be(false) }
  end
end
