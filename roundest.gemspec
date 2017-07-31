# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'roundest/version'

Gem::Specification.new do |spec|
  spec.name          = "roundest"
  spec.version       = Roundest::VERSION
  spec.authors       = ["Dan Hetherington"]
  spec.email         = ["dan.hetherington@gmail.com"]
  spec.summary       = %q{Given a range between two floating point numbers, find one of the 'roundest' (i.e. shortest, or ending in 5) numbers that are strictly within the range."}
  #spec.description   = %q{}
  spec.homepage      = 'http://rubygems.org/gems/roundest'
  spec.license       = "GNU General Public License version 3.0 (GPL-3.0)"

  spec.files         = `git ls-files -z`.split("\x0")
  #spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.required_ruby_version = '>= 2.1.0'

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake", ">= 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "coveralls"
  spec.add_development_dependency "pry"

  #spec.add_runtime_dependency "fuzzy_match", "~> 2.1"
  #spec.add_runtime_dependency "pry", ">= 0.10.1"
end
