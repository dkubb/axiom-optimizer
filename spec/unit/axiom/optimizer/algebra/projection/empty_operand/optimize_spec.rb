# encoding: utf-8

require 'spec_helper'

describe Optimizer::Algebra::Projection::EmptyOperand, '#optimize' do
  subject { object.optimize }

  let(:header)   { Relation::Header.coerce([[:id, Integer], [:name, String]]) }
  let(:base)     { Relation::Empty.new(header)                                }
  let(:relation) { base.project([:id])                                        }
  let(:object)   { described_class.new(relation)                              }

  before do
    expect(object).to be_optimizable
  end

  it { should be_kind_of(Relation::Empty) }

  its(:header) { should be(relation.header) }

  its(:tuples) { should be(relation) }
end
