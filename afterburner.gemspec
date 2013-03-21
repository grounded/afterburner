# encoding: utf-8
require File.expand_path('lib/afterburner/package', File.dirname(__FILE__))

Gem::Specification.new do |s|
  s.name        = "afterburner"
  s.version     = Afterburner::VERSION
  s.authors     = Afterburner::AUTHORS
  s.email       = Afterburner::EMAILS
  s.homepage    = Afterburner::HOMEPAGE
  s.summary     = Afterburner::SUMMARY
  s.description = Afterburner::DESCRIPTION

  s.required_ruby_version = Afterburner::REQUIRED_RUBY_VERSION
  s.require_paths         = ["lib"]

  s.files       = `git ls-files`.split($/)
  s.test_files  = s.files.split.grep(%r{^(spec)/})

end
