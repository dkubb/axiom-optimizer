# encoding: utf-8

require 'spec_helper'

describe Optimizer::Relation::Operation::Binary, '#left' do
  subject { object.left }

  let(:optimized) { mock('Optimized')                                }
  let(:left)      { mock('Left', :optimize => optimized)             }
  let(:right)     { mock('Right')                                    }
  let(:relation)  { mock('Relation', :left => left, :right => right) }
  let(:object)    { described_class.new(relation)                    }

  it { should equal(optimized) }
end
