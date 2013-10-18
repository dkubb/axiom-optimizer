# encoding: utf-8

require 'spec_helper'

describe Optimizer::Relation::Operation::Offset::UnoptimizedOperand, '#optimize' do
  subject { object.optimize }

  let(:header)   { Relation::Header.coerce([[:id, Integer]])                            }
  let(:sorted)   { Relation.new(header, LazyEnumerable.new([[1]])).sort_by { |r| r.id } }
  let(:relation) { sorted.rename({}).drop(1)                                            }
  let(:object)   { described_class.new(relation)                                        }

  before do
    expect(object).to be_optimizable
  end

  it { should be_kind_of(Relation::Operation::Offset) }

  its(:operand) { should be(sorted) }

  its(:offset) { should == 1 }
end
