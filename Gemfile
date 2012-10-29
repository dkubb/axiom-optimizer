# encoding: utf-8

source 'https://rubygems.org'

gem 'veritas', '~> 0.0.7', :github => 'dkubb/veritas'

group :development do
  gem 'jeweler', '~> 1.8.3'
  gem 'rake',    '~> 0.9.2'
  gem 'rspec',   '~> 1.3.2'
  gem 'yard',    '~> 0.8.3'
end

group :guard do
  gem 'guard',         '~> 0.7.0'
  gem 'guard-bundler', '~> 0.1.3'
  gem 'guard-rspec',   '~> 0.4.5'
end

platform :jruby do
  group :jruby do
    gem 'jruby-openssl', '~> 0.7.4'
  end
end

group :metrics do
  gem 'arrayfields',     '~> 4.7.4'
  gem 'fattr',           '~> 2.2.1'
  gem 'flay',            '~> 1.4.3'
  gem 'flog',            '~> 2.5.3'
  gem 'map',             '~> 5.4.0'
  gem 'reek',            '~> 1.2.8', :github => 'dkubb/reek'
  gem 'roodi',           '~> 2.1.0'
  gem 'tailor',          '~> 0.1.5'
  gem 'yardstick',       '~> 0.7.0'
  gem 'yard-spellcheck', '~> 0.1.4'

  platforms :mri_19 do
    gem 'cane',      '~> 1.1.0'
    gem 'simplecov', '~> 0.7.1'
  end

  platforms :mri_18, :rbx do
    gem 'heckle',    '~> 1.4.3'
    gem 'json',      '~> 1.6.6'
    gem 'mspec',     '~> 1.5.17'
    gem 'ruby2ruby', '=  1.2.2'
  end

  platforms :mri_18 do
    gem 'metric_fu', '~> 2.1.1'
    gem 'rcov',      '~> 1.0.0'
  end

  platforms :rbx do
    gem 'pelusa', '~> 0.2.0'
  end
end
