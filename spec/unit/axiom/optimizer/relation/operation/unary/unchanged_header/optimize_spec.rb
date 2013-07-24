# encoding: utf-8

require 'spec_helper'

describe Optimizer::Relation::Operation::Unary::UnchangedHeader, '#optimize' do
  subject { object.optimize }

  let(:operand)  { double('Operand')                                          }
  let(:header)   { double('Header')                                           }
  let(:relation) { double('Relation', :operand => operand, :header => header) }
  let(:object)   { described_class.new(relation)                              }

  it { should be(operand) }
end
