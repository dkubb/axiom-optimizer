# encoding: utf-8

require 'spec_helper'

describe Optimizer::Relation::Operation::Binary::EqualOperands, '#optimizable?' do
  subject { object.optimizable? }

  let(:described_class)  { Class.new(Optimizer::Relation::Operation::Binary) }
  let(:relation)         { double('Relation', left: left, right: right)      }
  let(:materialized)     { double('Materialized')                            }
  let(:not_materialized) { double('Not Materialized')                        }
  let(:object)           { described_class.new(relation)                     }

  before do
    described_class.class_eval { include superclass::EqualOperands }
  end

  context 'when left and right are equal' do
    let(:left)  { not_materialized }
    let(:right) { not_materialized }

    it { should be(true) }
  end

  context 'when left and right are not equal' do
    let(:left)  { not_materialized }
    let(:right) { materialized     }

    it { should be(false) }
  end
end
