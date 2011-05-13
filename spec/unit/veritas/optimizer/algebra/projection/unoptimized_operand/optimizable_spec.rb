require 'spec_helper'

describe Optimizer::Algebra::Projection::UnoptimizedOperand, '#optimizable?' do
  subject { object.optimizable? }

  let(:header)   { Relation::Header.new([ [ :id, Integer ], [ :name, String ] ]) }
  let(:base)     { Relation.new(header, [ [ 1, 'Dan Kubb' ] ].each)              }
  let(:relation) { operand.project([ :id ])                                      }
  let(:object)   { described_class.new(relation)                                 }

  before do
    object.operation.should be_kind_of(Algebra::Projection)
  end

  context 'when the operand is optimizable' do
    let(:operand) { base.restrict { Function::Proposition::Tautology.instance } }

    it { should be(true) }
  end

  context 'when the operand is not optimizable' do
    let(:operand) { base }

    it { should be(false) }
  end
end
