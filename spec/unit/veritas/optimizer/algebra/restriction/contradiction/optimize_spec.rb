# encoding: utf-8

require 'spec_helper'

describe Optimizer::Algebra::Restriction::Contradiction, '#optimize' do
  subject { object.optimize }

  let(:header)    { Relation::Header.coerce([ [ :id, Integer ] ]) }
  let(:base)      { Relation.new(header, [ [ 1 ] ].each)          }
  let(:predicate) { Function::Proposition::Contradiction.instance }
  let(:relation)  { base.restrict { predicate }                   }
  let(:object)    { described_class.new(relation)                 }

  before do
    object.should be_optimizable
  end

  it { should be_kind_of(Relation::Empty) }

  its(:header) { should equal(header) }

  its(:tuples) { should equal(relation) }
end
