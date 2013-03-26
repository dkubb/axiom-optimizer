# encoding: utf-8

require 'spec_helper'

describe Optimizer::Algebra::Summarization::EmptyOperand, '.extension_default' do
  subject { object.extension_default(function) }

  let(:object) { described_class }

  context 'when the function has a default' do
    let(:operand)  { mock('Operand')               }
    let(:function) { Aggregate::Count.new(operand) }

    it { should eql(0) }
  end

  context 'when the function does not have a default' do
    let(:function) { proc {} }

    it { should be_nil }
  end
end
