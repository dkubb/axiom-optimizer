# encoding: utf-8

require 'spec_helper'

describe Optimizer::Algebra::Projection::ExtensionOperand, '#optimize' do
  subject { object.optimize }

  let(:header)   { Relation::Header.new([ [ :id, Integer ], [ :name, String ], [ :age, Integer ] ])             }
  let(:base)     { Relation.new(header, [ [ 1, 'Dan Kubb', 35 ] ].each)                                         }
  let(:relation) { base.extend { |r| r.add(:subscriber, true); r.add(:active, true) }.project([ :id, :active ]) }
  let(:object)   { described_class.new(relation)                                                                }

  before do
    object.should be_optimizable
  end

  it { should be_kind_of(Algebra::Projection) }

  its(:operand) { should eql(base.extend { |r| r.add(:active, true) }) }

  its(:header) { should == [ header[:id], Attribute::Boolean.new(:active) ] }
end
