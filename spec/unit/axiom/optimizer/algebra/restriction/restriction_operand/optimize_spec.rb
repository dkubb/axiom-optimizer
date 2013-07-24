# encoding: utf-8

require 'spec_helper'

describe Optimizer::Algebra::Restriction::RestrictionOperand, '#optimize' do
  subject { object.optimize }

  let(:header)          { Relation::Header.coerce([[:id, Integer]])                }
  let(:base)            { Relation.new(header, LazyEnumerable.new([[1]]))          }
  let(:predicate)       { header[:id].eq(1)                                        }
  let(:other_predicate) { header[:id].include([1])                                 }
  let(:relation)        { base.restrict { predicate }.restrict { other_predicate } }
  let(:object)          { described_class.new(relation)                            }

  before do
    expect(object).to be_optimizable
  end

  it { should be_kind_of(Algebra::Restriction) }

  its(:operand) { should be(base) }

  its(:predicate) { should be(predicate) }
end
