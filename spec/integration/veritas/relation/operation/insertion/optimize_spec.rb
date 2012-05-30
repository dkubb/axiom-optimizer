# encoding: utf-8

require 'spec_helper'

describe Relation::Operation::Insertion, '#optimize' do
  subject { object.optimize }

  let(:object)         { described_class.new(left, right) }
  let(:original_left)  { Relation.new(header, left_body)  }
  let(:original_right) { Relation.new(header, right_body) }
  let(:header)         { [ attribute ]                    }
  let(:attribute)      { Attribute::Integer.new(:id)      }
  let(:left_body)      { [ [ 1 ] ].each                   }
  let(:right_body)     { [ [ 2 ] ].each                   }

  context 'left is a limit relation' do
    let(:left)  { original_left.sort_by  { header }.take(1) }
    let(:right) { original_right.sort_by { header }.take(1) }

    it 'does not push-down insertions' do
      should equal(object)
    end
  end

  context 'left is an offset relation' do
    let(:left)  { original_left.sort_by  { header }.drop(1) }
    let(:right) { original_right.sort_by { header }.drop(1) }

    it 'does not push-down insertions' do
      should equal(object)
    end
  end
end
