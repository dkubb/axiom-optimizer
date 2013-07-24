# encoding: utf-8

shared_examples_for 'Function::Connective::Binary#optimize' do
  context 'left and right are the same' do
    let(:left)  { attribute.gt(1) }
    let(:right) { attribute.gt(1) }

    it { should be(left) }

    it_should_behave_like 'an optimize method'
  end

  context 'left and right are the same, after optimizing the left' do
    let(:original_left) { attribute.gt(1)                                              }
    let(:left)          { original_left.and(Function::Proposition::Tautology.instance) }
    let(:right)         { attribute.gt(1)                                              }

    it { should be(original_left) }

    it_should_behave_like 'an optimize method'
  end

  context 'left and right are the same, after optimizing the right' do
    let(:left)  { attribute.gt(1)                                                }
    let(:right) { attribute.gt(1).and(Function::Proposition::Tautology.instance) }

    it { should be(left) }

    it_should_behave_like 'an optimize method'
  end

  context 'left and right are different' do
    let(:left)  { attribute.gt(1) }
    let(:right) { attribute.lt(1) }

    it { should be(object) }

    it_should_behave_like 'an optimize method'
  end

  context 'left and right are different, after optimizing the left' do
    let(:original_left) { attribute.gt(1)                                              }
    let(:left)          { original_left.and(Function::Proposition::Tautology.instance) }
    let(:right)         { attribute.lt(1)                                              }

    add_method_missing

    it { should_not be(object) }

    it { should be_kind_of(described_class) }

    its(:left) { should be(original_left) }

    its(:right) { should be(right) }

    it_should_behave_like 'an optimize method'
  end

  context 'left and right are different, after optimizing the right' do
    let(:original_right) { attribute.lt(1)                                               }
    let(:left)           { attribute.gt(1)                                               }
    let(:right)          { original_right.and(Function::Proposition::Tautology.instance) }

    add_method_missing

    it { should_not be(object) }

    it { should be_kind_of(described_class) }

    its(:left) { should be(left) }

    its(:right) { should be(original_right) }

    it_should_behave_like 'an optimize method'
  end

  context 'self and right are the same, and left and right.left are the same' do
    let(:left)  { attribute.eq(1)                                                           }
    let(:right) { double('Binary', class: described_class, left: left, :optimized? => true) }

    before do
      right.stub(optimize: right, :frozen? => true, memoize: right, memoized: right)
    end

    it { should be(right) }

    it_should_behave_like 'an optimize method'
  end

  context 'self and left are the same, and right and left.right are the same' do
    let(:left)  { double('Binary', class: described_class, right: right, :optimized? => true) }
    let(:right) { attribute.eq(1)                                                             }

    before do
      left.stub(optimize: left, :frozen? => true, memoize: left, memoized: left)
    end

    it { should be(left) }

    it_should_behave_like 'an optimize method'
  end
end
