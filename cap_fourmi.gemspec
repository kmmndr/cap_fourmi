# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cap_fourmi/version'

Gem::Specification.new do |spec|
  spec.name          = "cap_fourmi"
  spec.version       = CapFourmi::VERSION
  spec.authors       = ["Thomas Kienlen", "Guillaume Dott"]
  spec.email         = ["thomas.kienlen@lafourmi-immo.com", "guillaume.dott@lafourmi-immo.com"]
  spec.description   = %q{Capistrano 3 custom recipes}
  spec.summary       = %q{Capistrano 3 custom recipes for La Fourmi immo deployment}
  spec.homepage      = 'https://github.com/lafourmi/cap_fourmi'
  spec.license       = "AGPL"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "capistrano", "~> 3.0"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
