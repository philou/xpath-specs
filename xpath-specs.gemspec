# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'xpath/specs/version'

Gem::Specification.new do |spec|
  spec.name          = "xpath-specs"
  spec.version       = Xpath::Specs::VERSION
  spec.authors       = ["Philou"]
  spec.email         = ["philippe.bourgau@gmail.com"]
  spec.description   = %q{A gem providing recursive and named wrappers around xpaths, in order to improve error messages when testing xpath presence in html files}
  spec.summary       = %q{An RSpec library to get better messages when matching XPaths}
  spec.homepage      = "https://github.com/philou/xpath-specs"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "nokogiri"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
