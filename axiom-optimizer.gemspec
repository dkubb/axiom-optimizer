# encoding: utf-8

require File.expand_path('../lib/axiom/optimizer/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name        = 'axiom-optimizer'
  gem.version     = Axiom::Optimizer::VERSION.dup
  gem.authors     = ['Dan Kubb']
  gem.email       = 'dan.kubb@gmail.com'
  gem.description = 'Optimizes axiom relations'
  gem.summary     = gem.description
  gem.homepage    = 'https://github.com/dkubb/axiom-optimizer'
  gem.licenses    = %w[MIT]

  gem.require_paths    = %w[lib]
  gem.files            = `git ls-files`.split($/)
  gem.test_files       = `git ls-files -- spec/{unit,integration}`.split($/)
  gem.extra_rdoc_files = %w[LICENSE README.md CONTRIBUTING.md TODO]

  gem.add_runtime_dependency('axiom', '~> 0.1.0')

  gem.add_development_dependency('rake',  '~> 10.0.4')
  gem.add_development_dependency('rspec', '~> 2.13.0')
  gem.add_development_dependency('yard',  '~> 0.8.5.2')
end
