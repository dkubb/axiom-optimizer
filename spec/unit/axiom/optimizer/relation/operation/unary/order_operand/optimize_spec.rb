# encoding: utf-8

require 'spec_helper'

describe Optimizer::Relation::Operation::Unary::OrderOperand, '#optimize' do
  subject { object.optimize }

  let(:described_class) { Class.new(Optimizer::Relation::Operation::Unary)       }
  let(:base)            { Relation.new([ [ :id, Integer ] ], LazyEnumerable.new) }
  let(:operand)         { base.sort_by { |r| r.id }                              }
  let(:relation)        { operand.project([])                                    }
  let(:object)          { described_class.new(relation)                          }

  before do
    described_class.class_eval do
      include Optimizer::Relation::Operation::Unary::OrderOperand

      def wrap_operand
        'Optimized'
      end
    end

    object.should be_optimizable
  end

  it { should eql('Optimized') }
end
