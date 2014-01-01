# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cucumber/blanket/version'

Gem::Specification.new do |spec|
  spec.name          = "cucumber-blanket"
  spec.version       = Cucumber::Blanket::VERSION
  spec.authors       = ["Keyvan Fatehi"]
  spec.email         = ["keyvanfatehi@gmail.com"]
  spec.description   = %q{Extract Blanket.js code coverage data from within a Ruby Cucumber environment}
  spec.summary       = %q{Extract Blanket.js code coverage data from within a Ruby Cucumber environment}
  spec.homepage      = "https://github.com/keyvanfatehi/cucumber-blanket"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "pry"
end
