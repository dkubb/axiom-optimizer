# encoding: utf-8

require 'spec_helper'

describe Optimizer::Algebra::Rename::ProjectionOperand, '#optimizable?' do
  subject { object.optimizable? }

  let(:header) { Relation::Header.coerce([ [ :one, Integer ], [ :two, Integer ], [ :three, Integer ] ]) }
  let(:base)   { Relation.new(header, LazyEnumerable.new([ [ 1, 2 ] ]))                                 }
  let(:object) { described_class.new(relation)                                                          }

  before do
    object.operation.should be_kind_of(Algebra::Rename)
  end

  context 'when the operand is a projection and the aliases do not conflict with a removed column' do
    let(:operand)  { base.project([ :one, :two ])                 }
    let(:relation) { operand.rename(:one => :other, :two => :one) }

    it { should be(true) }
  end

  context 'when the operand is a projection and the alias does not conflict with a removed column' do
    let(:operand)  { base.project([ :one ])         }
    let(:relation) { operand.rename(:one => :other) }

    it { should be(true) }
  end

  context 'when the operand is a projection and the alias conflicts with a removed column' do
    let(:operand)  { base.project([ :one ])       }
    let(:relation) { operand.rename(:one => :two) }

    it { should be(false) }
  end

  context 'when the operand is not a projection' do
    let(:operand)  { base                           }
    let(:relation) { operand.rename(:one => :other) }

    it { should be(false) }
  end
end
