# encoding: utf-8

require 'spec_helper'

describe Optimizer::Relation::Materialized::EmptyOperand, '#optimize' do
  subject { object.optimize }

  let(:header)   { Relation::Header.coerce([ [ :id, Integer ] ]) }
  let(:relation) { Relation.new(header, LazyEnumerable.new)      }
  let(:object)   { described_class.new(relation)                 }

  before do
    expect(object).to be_optimizable
  end

  it { should be_kind_of(Relation::Empty) }

  its(:header) { should be(header) }

  its(:tuples) { should be(relation) }
end
