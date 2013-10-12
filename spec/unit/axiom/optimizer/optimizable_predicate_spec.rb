# encoding: utf-8

require 'spec_helper'

describe Optimizer, '#optimizable?' do
  subject { object.optimizable? }

  let(:described_class) { Class.new(Optimizer)           }
  let(:operation)       { double('Operation')            }
  let(:object)          { described_class.new(operation) }

  before do
    described_class.stub(:to_s).and_return('Optimizer')
  end

  specify { expect { subject }.to raise_error(NotImplementedError, 'Optimizer#optimizable? is not implemented') }
end
