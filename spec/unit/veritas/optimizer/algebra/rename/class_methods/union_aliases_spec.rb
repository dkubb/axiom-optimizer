# encoding: utf-8

require 'spec_helper'

describe Optimizer::Algebra::Rename, '.union_aliases' do
  subject { object.union_aliases(aliases, operand) }

  let(:attribute) { Attribute::Integer.new(:id)                }
  let(:header)    { Relation::Header.new([ [ :id, Integer ] ]) }
  let(:base)      { Relation.new(header, [ [ 1 ] ].each)       }
  let(:aliases)   { relation.aliases                           }
  let(:object)    { Optimizer::Algebra::Rename                 }

  context 'when the operand is a rename' do
    let(:operand)  { base.rename(:id => :other_id)            }
    let(:relation) { operand.rename(:other_id => :another_id) }

    it { should be_kind_of(Algebra::Rename::Aliases) }

    it { should == { attribute => attribute.rename(:another_id) } }
  end

  context 'when the operand is not a rename' do
    let(:operand)  { base                             }
    let(:relation) { operand.rename(:id => :other_id) }

    it { should equal(aliases) }
  end
end
