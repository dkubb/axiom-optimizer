require 'spec_helper'

describe Optimizer::Algebra::Restriction::Tautology, '#optimize' do
  subject { object.optimize }

  let(:header)    { Relation::Header.new([ [ :id, Integer ] ]) }
  let(:base)      { Relation.new(header, [ [ 1 ] ].each)       }
  let(:predicate) { Function::Proposition::Tautology.instance  }
  let(:relation)  { base.restrict { predicate }                }
  let(:object)    { described_class.new(relation)              }

  before do
    object.should be_optimizable
  end

  it { should equal(base) }
end
