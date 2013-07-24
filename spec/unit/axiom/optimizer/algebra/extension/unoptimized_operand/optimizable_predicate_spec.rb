# encoding: utf-8

require 'spec_helper'

describe Optimizer::Algebra::Extension::UnoptimizedOperand, '#optimizable?' do
  subject { object.optimizable? }

  let(:header)   { Relation::Header.coerce([[:id, Integer]])       }
  let(:base)     { Relation.new(header, LazyEnumerable.new([[1]])) }
  let(:relation) { operand.extend { |r| r.add(*extensions) }       }
  let(:object)   { described_class.new(relation)                   }

  before do
    expect(object.operation).to be_kind_of(Algebra::Extension)
  end

  context 'when the operand is optimizable' do
    let(:operand)    { base.rename({}) }
    let(:extensions) { [:text, 1]      }

    it { should be(true) }
  end

  context 'when the extensions are optimizable' do
    let(:operand)    { base                                        }
    let(:extensions) { [:text, Function::Numeric::Absolute.new(1)] }

    it { should be(true) }
  end

  context 'when the operand and extensions are not optimizable' do
    let(:operand)    { base       }
    let(:extensions) { [:text, 1] }

    it { should be(false) }
  end
end
