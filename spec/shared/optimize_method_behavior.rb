# encoding: utf-8

shared_examples_for 'an optimize method' do
  it_should_behave_like 'an idempotent method'

  it 'it memoizes itself for #optimize' do
    optimized = subject
    expect(optimized.memoized(:optimize)).to be(optimized)
  end

  it 'does not optimize further' do
    optimized = subject
    optimized.memoize(:optimize, nil)  # clear memoized value
    expect(optimized.optimize).to eql(optimized)
  end
end
