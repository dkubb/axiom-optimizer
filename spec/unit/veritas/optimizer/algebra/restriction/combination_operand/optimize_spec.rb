# encoding: utf-8

require 'spec_helper'

describe Optimizer::Algebra::Restriction::CombinationOperand, '#optimize' do
  subject { object.optimize }

  let(:left)     { Relation.new([ [ :id, Integer ], [ :user_name,     String ] ], [ [ 1, 'Dan Kubb' ] ].each) }
  let(:right)    { Relation.new([ [ :id, Integer ], [ :employee_name, String ] ], [ [ 2, 'Dan Kubb' ] ].each) }
  let(:operand)  { left.join(right)                                                                           }
  let(:relation) { operand.restrict {}                                                                        }
  let(:object)   { described_class.new(relation)                                                              }

  before do
    object.should be_optimizable
  end

  specify { expect { subject }.to raise_error(NotImplementedError, 'Veritas::Optimizer::Algebra::Restriction::CombinationOperand#optimize must be implemented') }
end
