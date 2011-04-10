require 'rake'

require File.expand_path('../lib/veritas/optimizer/version', __FILE__)

begin
  gem('jeweler', '~> 1.5.2') if respond_to?(:gem, true)
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
  puts 'Jeweler (or a dependency) not available. Install it with: gem install jeweler -v 1.5.2'
end
