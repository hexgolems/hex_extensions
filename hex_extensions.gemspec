# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hex_extensions/version'

Gem::Specification.new do |spec|
  spec.name          = "hex_extensions"
  spec.version       = HexExtensions::VERSION
  spec.authors       = ["coco"]
  spec.email         = ["coco@hexgolems.com"]
  spec.summary       = %q{Common usefull methods, no monkey patches}
  spec.description   = %q{Usefull methods for Ranges, Hashes. Currently no monkeypatches are performed.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
