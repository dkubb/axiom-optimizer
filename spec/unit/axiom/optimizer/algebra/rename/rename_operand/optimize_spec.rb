# encoding: utf-8

require 'spec_helper'

describe Optimizer::Algebra::Rename::RenameOperand, '#optimize' do
  subject { object.optimize }

  let(:header)   { Relation::Header.coerce([[:id, Integer], [:name, String]])  }
  let(:base)     { Relation.new(header, LazyEnumerable.new([[1, 'Dan Kubb']])) }
  let(:relation) { base.rename(name: :other_name).rename(id: :other_id)        }
  let(:object)   { described_class.new(relation)                               }

  before do
    expect(object).to be_optimizable
  end

  it { should be_kind_of(Algebra::Rename) }

  its(:operand) { should be(base) }

  its(:header) { should == [[:other_id, Integer], [:other_name, String]] }
end
