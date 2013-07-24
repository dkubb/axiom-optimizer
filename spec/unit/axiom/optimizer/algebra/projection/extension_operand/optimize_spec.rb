# encoding: utf-8

require 'spec_helper'

describe Optimizer::Algebra::Projection::ExtensionOperand, '#optimize' do
  subject { object.optimize }

  let(:header) { Relation::Header.coerce([[:id, Integer], [:name, String], [:age, Integer]]) }
  let(:base)   { Relation.new(header, LazyEnumerable.new([[1, 'Dan Kubb', 35]]))             }
  let(:object) { described_class.new(relation)                                               }

  let(:relation) do
    base.extend do |relation|
      relation.add(:subscriber, true)
      relation.add(:active, true)
    end.project([:id, :active])
  end

  before do
    expect(object).to be_optimizable
  end

  it { should be_kind_of(Algebra::Projection) }

  its(:operand) { should eql(base.extend { |r| r.add(:active, true) }) }

  its(:header) { should == [header[:id], Attribute::Boolean.new(:active)] }
end
