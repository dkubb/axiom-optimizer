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
  gem.license     = 'MIT'

  gem.require_paths    = %w[lib]
  gem.files            = `git ls-files`.split($/)
  gem.test_files       = `git ls-files -- spec/{unit,integration}`.split($/)
  gem.extra_rdoc_files = %w[LICENSE README.md CONTRIBUTING.md TODO]

  gem.add_runtime_dependency('axiom', '~> 0.1.1')

  gem.add_development_dependency('bundler', '~> 1.5', '>= 1.5.2')
end
