# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "skinner/version"

Gem::Specification.new do |spec|
  spec.name          = "skinner"
  spec.version       = Skinner::VERSION
  spec.authors       = ["pseudomuto"]
  spec.email         = ["david.muto@gmail.com"]
  spec.summary       = "Common components for themes"
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(/^bin\//) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(/^(test|spec|features)\//)
  spec.require_paths = ["lib"]

  spec.add_dependency "liquid"
  spec.add_dependency "nokogiri"
  spec.add_dependency "activesupport", "~> 4.2"
end
