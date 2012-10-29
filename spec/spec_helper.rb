# encoding: utf-8

if RUBY_VERSION >= '1.9' and ENV['COVERAGE'] == 'true'
  require 'simplecov'
  SimpleCov.start do
    command_name     'spec:unit'
    add_filter       'spec'
    minimum_coverage 100
  end
end

require 'veritas-optimizer'
require 'spec'
require 'spec/autorun'

include Veritas

# require spec support files and shared behavior
Dir[File.expand_path('../{support,shared}/**/*.rb', __FILE__)].each do |file|
  require file
end

Spec::Runner.configure do |config|
  config.extend AddMethodMissing
end

# change the heckle timeout to be 5 seconds
if defined?(::Heckle)
  class ::Heckle
    @@timeout = 5
  end
end
