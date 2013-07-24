# encoding: utf-8

require 'spec_helper'

describe Optimizer::Relation::Operation::Unary::UnchangedHeader, '#optimizable?' do
  subject { object.optimizable? }

  let(:operand)  { double('Operand', header: operand_header)            }
  let(:header)   { double('Header')                                     }
  let(:relation) { double('Relation', operand: operand, header: header) }
  let(:object)   { described_class.new(relation)                        }

  context 'when the header is not changed' do
    let(:operand_header) { header }

    it { should be(true) }
  end

  context 'when the header is changed' do
    let(:operand_header) { double('Changed Header') }

    it { should be(false) }
  end
end
