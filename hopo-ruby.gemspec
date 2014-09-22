# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hopo/version'

Gem::Specification.new do |spec|
  spec.name          = "hopo-ruby"
  spec.version       = Hopo::VERSION
  spec.authors       = ["Mike Reinmiller"]
  spec.email         = ["mike@honestpolicy.com"]
  spec.summary       = %q{A simple library for communicating with the Honest Policy API}
  spec.description   = %q{Easily connect to multiple Honest Policy APIs including the Rater, Leads, Vehicles and Carrier Quality}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"

  spec.add_development_dependency 'pry', "~> 0.10.1"

end
