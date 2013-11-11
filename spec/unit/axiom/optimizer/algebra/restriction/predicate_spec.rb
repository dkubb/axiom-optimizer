# encoding: utf-8

require 'spec_helper'

describe Optimizer::Algebra::Restriction, '#predicate' do
  subject { object.predicate }

  let(:object)          { described_class.new(relation)              }
  let(:described_class) { Class.new(Optimizer::Algebra::Restriction) }
  let(:base)            { Relation.new([[:id, Integer]], [[1]])      }
  let(:predicate)       { base[:id].eq(1)                            }
  let(:relation)        { base.restrict { predicate }                }

  before do
    expect(object.operation).to be_kind_of(Algebra::Restriction)
  end

  it { should be(predicate) }
end
