# encoding: utf-8

require 'spec_helper'

describe Optimizer::Relation::Operation::Binary, '#left' do
  subject { object.left }

  let(:optimized) { double('Optimized')                          }
  let(:left)      { double('Left', optimize: optimized)          }
  let(:right)     { double('Right')                              }
  let(:relation)  { double('Relation', left: left, right: right) }
  let(:object)    { described_class.new(relation)                }

  it { should be(optimized) }
end
