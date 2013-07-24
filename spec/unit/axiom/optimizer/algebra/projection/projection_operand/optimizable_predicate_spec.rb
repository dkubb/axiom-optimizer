# encoding: utf-8

require 'spec_helper'

describe Optimizer::Algebra::Projection::ProjectionOperand, '#optimizable?' do
  subject { object.optimizable? }

  let(:header)   { Relation::Header.coerce([ [ :id, Integer ], [ :name, String ], [ :age, Integer ] ]) }
  let(:base)     { Relation.new(header, LazyEnumerable.new([ [ 1, 'Dan Kubb', 35 ] ]))                 }
  let(:relation) { operand.project([ :id ])                                                            }
  let(:object)   { described_class.new(relation)                                                       }

  before do
    expect(object.operation).to be_kind_of(Algebra::Projection)
  end

  context 'when the operand is a projection' do
    let(:operand) { base.project([ :id, :name ]) }

    it { should be(true) }
  end

  context 'when the operand is not a projection' do
    let(:operand) { base }

    it { should be(false) }
  end
end
