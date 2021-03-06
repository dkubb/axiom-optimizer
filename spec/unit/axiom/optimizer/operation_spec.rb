# encoding: utf-8

require 'spec_helper'

describe Optimizer, '#operation' do
  subject { object.operation }

  let(:described_class) { Class.new(Optimizer)           }
  let(:operation)       { double('Operation')            }
  let(:object)          { described_class.new(operation) }

  it { should be(operation) }
end
