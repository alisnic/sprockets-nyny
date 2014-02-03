# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sprockets/nyny/version'

Gem::Specification.new do |spec|
  spec.name          = "sprockets-nyny"
  spec.version       = Sprockets::NYNY::VERSION
  spec.authors       = ["Andrei Lisnic"]
  spec.email         = ["andrei.lisnic@gmail.com"]
  spec.summary       = %q{assets pipeline for NYNY}
  spec.description   = %q{Provides integration for asset pipeline into New York, New York}
  spec.homepage      = "https://github.com/alisnic/sprockets-nyny"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_dependency "sprockets-rails", "~> 2.0.1"
  spec.add_dependency "nyny", "~> 3.2.2"
end
