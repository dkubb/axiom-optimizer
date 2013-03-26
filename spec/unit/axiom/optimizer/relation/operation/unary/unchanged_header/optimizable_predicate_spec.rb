# encoding: utf-8

require 'spec_helper'

describe Optimizer::Relation::Operation::Unary::UnchangedHeader, '#optimizable?' do
  subject { object.optimizable? }

  let(:operand)  { mock('Operand', :header => operand_header)               }
  let(:header)   { mock('Header')                                           }
  let(:relation) { mock('Relation', :operand => operand, :header => header) }
  let(:object)   { described_class.new(relation)                            }

  context 'when the header is not changed' do
    let(:operand_header) { header }

    it { should be(true) }
  end

  context 'when the header is changed' do
    let(:operand_header) { mock('Changed Header') }

    it { should be(false) }
  end
end
