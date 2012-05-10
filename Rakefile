# encoding: utf-8

require 'rake'

require File.expand_path('../lib/veritas/optimizer/version', __FILE__)

begin
  require 'jeweler'

  Jeweler::Tasks.new do |gem|
    gem.name        = 'veritas-optimizer'
    gem.summary     = 'Relational algebra optimizer'
    gem.description = 'Optimizes veritas relations'
    gem.email       = 'dan.kubb@gmail.com'
    gem.homepage    = 'https://github.com/dkubb/veritas-optimizer'
    gem.authors     = [ 'Dan Kubb' ]

    gem.version = Veritas::Optimizer::VERSION
  end

  Jeweler::GemcutterTasks.new

  FileList['tasks/**/*.rake'].each { |task| import task }
rescue LoadError
  puts 'Jeweler (or a dependency) not available. Install it with: gem install jeweler'
end
