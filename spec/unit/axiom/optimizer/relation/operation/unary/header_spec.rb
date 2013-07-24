# encoding: utf-8

require 'spec_helper'

describe Optimizer::Relation::Operation::Unary, '#header' do
  subject { object.header }

  let(:described_class) { Class.new(Optimizer::Relation::Operation::Unary)           }
  let(:operand)         { double('Operand')                                          }
  let(:header)          { double('Header')                                           }
  let(:relation)        { double('Relation', :operand => operand, :header => header) }
  let(:object)          { described_class.new(relation)                              }

  it { should be(header) }
end
