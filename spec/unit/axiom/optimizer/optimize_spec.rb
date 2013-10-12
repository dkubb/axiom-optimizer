# encoding: utf-8

require 'spec_helper'

describe Optimizer, '#optimize' do
  subject { object.optimize }

  let(:described_class) { Class.new(Optimizer)           }
  let(:operation)       { double('Operation')            }
  let(:object)          { described_class.new(operation) }

  specify { expect { subject }.to raise_error(NotImplementedError, "#{described_class}#optimize is not implemented") }
end
