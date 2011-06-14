# encoding: utf-8

require 'spec_helper'

describe Optimizer::Algebra::Restriction::OrderOperand, '#optimize' do
  subject { object.optimize }

  let(:base)      { Relation.new([ [ :id, Integer ] ], [ [ 1 ] ].each) }
  let(:predicate) { base[:id].eq(1)                                    }
  let(:relation)  { base.sort_by { |r| r.id }.restrict { predicate }   }
  let(:object)    { described_class.new(relation)                      }

  before do
    object.should be_optimizable
  end

  it { should be_kind_of(Algebra::Restriction) }

  its(:operand) { should equal(base) }

  its(:predicate) { should equal(predicate) }
end
