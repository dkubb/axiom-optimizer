# encoding: utf-8

require 'spec_helper'

describe Optimizer::Algebra::Restriction::Tautology, '#optimize' do
  subject { object.optimize }

  let(:header)    { Relation::Header.coerce([[:id, Integer]])       }
  let(:base)      { Relation.new(header, LazyEnumerable.new([[1]])) }
  let(:predicate) { Function::Proposition::Tautology.instance       }
  let(:relation)  { base.restrict { predicate }                     }
  let(:object)    { described_class.new(relation)                   }

  before do
    expect(object).to be_optimizable
  end

  it { should be(base) }
end
