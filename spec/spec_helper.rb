unless ENV['TRAVIS']
  require 'simplecov'
  SimpleCov.start do
    add_filter "/spec/"
  end
end
require File.expand_path('../shared/protocols', __FILE__)
