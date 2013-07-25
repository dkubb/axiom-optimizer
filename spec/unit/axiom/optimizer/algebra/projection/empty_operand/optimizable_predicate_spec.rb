# encoding: utf-8

require 'spec_helper'

describe Optimizer::Algebra::Projection::EmptyOperand, '#optimizable?' do
  subject { object.optimizable? }

  let(:header)   { Relation::Header.coerce([[:id, Integer], [:name, String]]) }
  let(:relation) { operand.project([:id])                                     }
  let(:object)   { described_class.new(relation)                              }

  before do
    expect(object.operation).to be_kind_of(Algebra::Projection)
  end

  context 'when the operand is empty' do
    let(:operand) { Relation.new(header) }

    it { should be(true) }
  end

  context 'when the operand is not empty' do
    let(:operand) { Relation.new(header, [[1, 'Dan Kubb']]) }

    it { should be(false) }
  end
end
