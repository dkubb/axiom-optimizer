# encoding: utf-8

require 'spec_helper'

describe Optimizer::Algebra::Join::MaterializedRight, '#optimizable?' do
  subject { object.optimizable? }

  let(:relation) { left.join(right)              }
  let(:object)   { described_class.new(relation) }

  before do
    expect(object.operation).to be_kind_of(Algebra::Join)
  end

  context 'when the right is materialized and left is not a restriction' do
    let(:left)  { Relation.new([[:id, Integer], [:name, String]], LazyEnumerable.new([[1, 'Dan Kubb']])) }
    let(:right) { Relation.new([[:id, Integer], [:age, Integer]], [[1, 35]])                             }

    it { should be(true) }
  end

  context 'when the right is materialized and left is a restriction not matching the right' do
    let(:left)  { Relation.new([[:id, Integer], [:name, String]], LazyEnumerable.new([[1, 'Dan Kubb']])).restrict { |r| r.name.eq('Dan Kubb') } }
    let(:right) { Relation.new([[:id, Integer], [:age, Integer]], [[1, 35]])                                                                    }

    it { should be(true) }
  end

  context 'when the right is materialized and left is a restriction matching the right' do
    let(:left)  { Relation.new([[:id, Integer], [:name, String]], LazyEnumerable.new([[1, 'Dan Kubb']])).restrict { |r| r.id.eq(1) } }
    let(:right) { Relation.new([[:id, Integer], [:age, Integer]], [[1, 35]])                                                         }

    it { should be(false) }
  end

  context 'when the left is not materialized' do
    let(:left)  { Relation.new([[:id, Integer], [:name, String]], LazyEnumerable.new([[1, 'Dan Kubb']])) }
    let(:right) { Relation.new([[:id, Integer], [:age, Integer]], LazyEnumerable.new([[1, 35]]))         }

    it { should be(false) }
  end
end
