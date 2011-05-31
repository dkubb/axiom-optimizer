# encoding: utf-8

require 'spec_helper'

describe Optimizer::Algebra::Rename, '#aliases' do
  subject { object.aliases }

  let(:attribute) { Attribute::Integer.new(:id)          }
  let(:header)    { Relation::Header.new([ attribute ])  }
  let(:base)      { Relation.new(header, [ [ 1 ] ].each) }
  let(:aliases)   { { :id => :other_id }                 }
  let(:object)    { described_class.new(relation)        }

  before do
    object.operation.should be_kind_of(Algebra::Rename)
  end

  let(:relation) { base.rename(aliases) }

  it { should be_kind_of(Algebra::Rename::Aliases) }

  it { should equal(relation.aliases) }
end
