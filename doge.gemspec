# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'doge/version'

Gem::Specification.new do |spec|
  spec.name          = "doge"
  spec.version       = Doge::VERSION
  spec.authors       = ["Pascal Jungblut"]
  spec.email         = ["mail@pascal-jungblut.com"]
  spec.description   = %q{such gem}
  spec.summary       = %q{wow}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "rmagick"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
