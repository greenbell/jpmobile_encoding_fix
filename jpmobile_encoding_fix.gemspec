# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'jpmobile_encoding_fix/version'

Gem::Specification.new do |spec|
  spec.name          = "jpmobile_encoding_fix"
  spec.version       = JpmobileEncodingFix::VERSION
  spec.authors       = ["M.Shibuya"]
  spec.email         = ["mit.shibuya@gmail.com"]
  spec.summary       = %q{Patch collection to work with Jpmobile encoding issues}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "activesupport", "~> 3.0"
  spec.add_runtime_dependency "jpmobile", "~> 3.0"
  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
