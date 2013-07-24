# encoding: utf-8

require 'spec_helper'

describe Optimizer::Algebra::Join::MaterializedLeft, '#optimizable?' do
  subject { object.optimizable? }

  let(:relation) { left.join(right)              }
  let(:object)   { described_class.new(relation) }

  before do
    expect(object.operation).to be_kind_of(Algebra::Join)
  end

  context 'when the left is materialized and right is not a restriction' do
    let(:left)  { Relation.new([ [ :id, Integer ], [ :name, String  ] ], [ [ 1, 'Dan Kubb' ] ])             }
    let(:right) { Relation.new([ [ :id, Integer ], [ :age,  Integer ] ], LazyEnumerable.new([ [ 1, 35 ] ])) }

    it { should be(true) }
  end

  context 'when the left is materialized and right is a restriction not matching the left' do
    let(:left)  { Relation.new([ [ :id, Integer ], [ :name, String  ] ], [ [ 1, 'Dan Kubb' ] ])                                           }
    let(:right) { Relation.new([ [ :id, Integer ], [ :age,  Integer ] ], LazyEnumerable.new([ [ 1, 35 ] ])).restrict { |r| r.age.eq(35) } }

    it { should be(true) }
  end

  context 'when the left is materialized and right is a restriction matching the left' do
    let(:left)  { Relation.new([ [ :id, Integer ], [ :name, String  ] ], [ [ 1, 'Dan Kubb' ] ])                                         }
    let(:right) { Relation.new([ [ :id, Integer ], [ :age,  Integer ] ], LazyEnumerable.new([ [ 1, 35 ] ])).restrict { |r| r.id.eq(1) } }

    it { should be(false) }
  end

  context 'when the left is not materialized' do
    let(:left)  { Relation.new([ [ :id, Integer ], [ :name, String  ] ], LazyEnumerable.new([ [ 1, 'Dan Kubb' ] ])) }
    let(:right) { Relation.new([ [ :id, Integer ], [ :age,  Integer ] ], LazyEnumerable.new([ [ 1, 35         ] ])) }

    it { should be(false) }
  end
end
