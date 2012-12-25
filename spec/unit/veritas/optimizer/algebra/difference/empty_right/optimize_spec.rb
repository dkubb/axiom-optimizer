# encoding: utf-8

require 'spec_helper'

describe Optimizer::Algebra::Difference::EmptyRight, '#optimize' do
  subject { object.optimize }

  let(:header)   { Relation::Header.coerce([ [ :id, Integer ] ]) }
  let(:left)     { Relation.new(header, [ [ 1 ] ].each)          }
  let(:right)    { Relation::Empty.new(header)                   }
  let(:relation) { left.difference(right)                        }
  let(:object)   { described_class.new(relation)                 }

  before do
    object.should be_optimizable
  end

  it { should equal(left) }
end
