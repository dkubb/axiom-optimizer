# encoding: utf-8

require 'spec_helper'

describe Optimizer::Relation::Operation::Unary::UnchangedHeader, '#optimize' do
  subject { object.optimize }

  let(:operand)  { mock('Operand')                                          }
  let(:header)   { mock('Header')                                           }
  let(:relation) { mock('Relation', :operand => operand, :header => header) }
  let(:object)   { described_class.new(relation)                            }

  it { should equal(operand) }
end
