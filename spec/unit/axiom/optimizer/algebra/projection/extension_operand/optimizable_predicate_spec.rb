# encoding: utf-8

require 'spec_helper'

describe Optimizer::Algebra::Projection::ExtensionOperand, '#optimizable?' do
  subject { object.optimizable? }

  let(:header)   { Relation::Header.coerce([[:id, Integer], [:name, String], [:age, Integer]]) }
  let(:base)     { Relation.new(header, LazyEnumerable.new([[1, 'Dan Kubb', 35]]))             }
  let(:relation) { operand.project([:id, :name])                                               }
  let(:object)   { described_class.new(relation)                                               }

  before do
    expect(object.operation).to be_kind_of(Algebra::Projection)
  end

  context 'when the operand is an extension, and the extended attribtue is removed ' do
    let(:operand) { base.extend { |r| r.add(:active, true) } }

    it { should be(true) }
  end

  context 'when the operand is an extension, and the extended attribtue is not removed ' do
    let(:operand)  { base.extend { |r| r.add(:active, true) } }
    let(:relation) { operand.project([:id, :name, :active])   }

    it { should be(false) }
  end

  context 'when the operand is not an extension' do
    let(:operand) { base }

    it { should be(false) }
  end
end
