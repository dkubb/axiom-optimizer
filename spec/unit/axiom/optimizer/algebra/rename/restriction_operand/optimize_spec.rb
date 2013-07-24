# encoding: utf-8

require 'spec_helper'

describe Optimizer::Algebra::Rename::RestrictionOperand, '#optimize' do
  subject { object.optimize }

  let(:header)    { Relation::Header.coerce([[:id, Integer]])         }
  let(:base)      { Relation.new(header, LazyEnumerable.new([[1]]))   }
  let(:predicate) { base[:id].eq(1)                                   }
  let(:relation)  { base.restrict { predicate }.rename(id: :other_id) }
  let(:object)    { described_class.new(relation)                     }

  before do
    expect(object).to be_optimizable
  end

  it { should be_kind_of(Algebra::Restriction) }

  its(:operand) { should eql(base.rename(id: :other_id)) }

  its(:predicate) { should == header[:id].rename(:other_id).eq(1) }
end
