# encoding: utf-8

require File.expand_path('../lib/veritas/optimizer/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name             = 'veritas-optimizer'
  gem.version          = Veritas::Optimizer::VERSION.dup
  gem.authors          = ['Dan Kubb']
  gem.email            = 'dan.kubb@gmail.com'
  gem.description      = 'Optimizes veritas relations'
  gem.summary          = gem.description
  gem.homepage         = 'https://github.com/dkubb/veritas-optimizer'

  gem.require_paths    = %w[lib]
  gem.files            = `git ls-files`.split($/)
  gem.test_files       = `git ls-files spec/{unit,integration}`.split($/)
  gem.extra_rdoc_files = %w[LICENSE README.md TODO]

  gem.add_runtime_dependency('veritas', '~> 0.0.7')

  gem.add_development_dependency('rake',  '~> 10.0.3')
  gem.add_development_dependency('rspec', '~> 1.3.2')
  gem.add_development_dependency('yard',  '~> 0.8.5.2')
end
