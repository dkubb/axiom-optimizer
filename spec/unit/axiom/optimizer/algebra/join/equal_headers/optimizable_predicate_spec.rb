# encoding: utf-8

require 'spec_helper'

describe Optimizer::Algebra::Join::EqualHeaders, '#optimizable?' do
  subject { object.optimizable? }

  let(:relation) { left.join(right)              }
  let(:object)   { described_class.new(relation) }

  before do
    expect(object.operation).to be_kind_of(Algebra::Join)
  end

  context 'when left and right headers are equal' do
    let(:header) { Relation::Header.coerce([[:id, Integer]])       }
    let(:left)   { Relation.new(header, LazyEnumerable.new([[1]])) }
    let(:right)  { Relation.new(header, LazyEnumerable.new([[1]])) }

    it { should be(true) }
  end

  context 'when left and right headers are not equal' do
    let(:left)  { Relation.new([[:id, Integer]], LazyEnumerable.new([[1]]))                              }
    let(:right) { Relation.new([[:id, Integer], [:name, String]], LazyEnumerable.new([[1, 'Dan Kubb']])) }

    it { should be(false) }
  end
end
