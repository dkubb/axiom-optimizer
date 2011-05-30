# encoding: utf-8

require 'spec_helper'

describe Optimizer::Relation::Operation::Binary, '#right' do
  subject { object.right }

  let(:optimized) { mock('Optimized')                                }
  let(:left)      { mock('Left')                                     }
  let(:right)     { mock('Right', :optimize => optimized)            }
  let(:relation)  { mock('Relation', :left => left, :right => right) }
  let(:object)    { described_class.new(relation)                    }

  it { should equal(optimized) }
end
