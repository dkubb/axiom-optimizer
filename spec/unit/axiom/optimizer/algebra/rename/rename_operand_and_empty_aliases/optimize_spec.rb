# encoding: utf-8

require 'spec_helper'

describe Optimizer::Algebra::Rename::RenameOperandAndEmptyAliases, '#optimize' do
  subject { object.optimize }

  let(:header)   { Relation::Header.coerce([[:id, Integer], [:name, String]])  }
  let(:base)     { Relation.new(header, LazyEnumerable.new([[1, 'Dan Kubb']])) }
  let(:relation) { base.rename(id: :other_id).rename(other_id: :id)            }
  let(:object)   { described_class.new(relation)                               }

  before do
    expect(object).to be_optimizable
  end

  it { should be(base) }
end
