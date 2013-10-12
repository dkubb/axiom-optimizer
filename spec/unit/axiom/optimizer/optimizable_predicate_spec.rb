# encoding: utf-8

require 'spec_helper'

describe Optimizer, '#optimizable?' do
  subject { object.optimizable? }

  let(:described_class) { Class.new(Optimizer)           }
  let(:operation)       { double('Operation')            }
  let(:object)          { described_class.new(operation) }

  specify { expect { subject }.to raise_error(NotImplementedError, "#{described_class}#optimizable? is not implemented") }
end
