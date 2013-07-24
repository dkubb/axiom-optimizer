# encoding: utf-8

require 'spec_helper'

describe Optimizer::Algebra::Restriction::UnoptimizedOperand, '#optimize' do
  subject { object.optimize }

  let(:header)   { Relation::Header.coerce([[:id, Integer]])       }
  let(:base)     { Relation.new(header, LazyEnumerable.new([[1]])) }
  let(:relation) { base.rename({}).restrict { |r| r.id.eq(1) }     }
  let(:object)   { described_class.new(relation)                   }

  before do
    expect(object).to be_optimizable
  end

  it { should be_kind_of(Algebra::Restriction) }

  it { should_not be(relation) }

  its(:operand) { should be(base) }

  its(:predicate) { should == base[:id].eq(1) }
end
