# encoding: utf-8

require 'spec_helper'

describe Optimizer::Relation::Operation::Binary, '#right' do
  subject { object.right }

  let(:optimized) { double('Optimized')                                }
  let(:left)      { double('Left')                                     }
  let(:right)     { double('Right', :optimize => optimized)            }
  let(:relation)  { double('Relation', :left => left, :right => right) }
  let(:object)    { described_class.new(relation)                      }

  it { should equal(optimized) }
end
