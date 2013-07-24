# encoding: utf-8

require 'spec_helper'

describe Optimizer::Function::Connective::Binary, '#right' do
  subject { object.right }

  let(:optimized_left)  { double('Optimized Left')                             }
  let(:optimized_right) { double('Optimized Right')                            }
  let(:left)            { double('Left',  :optimize => optimized_left)         }
  let(:right)           { double('Right', :optimize => optimized_right)        }
  let(:connective)      { double('Connective', :left => left, :right => right) }
  let(:object)          { described_class.new(connective)                      }

  it { should be(optimized_right) }
end
