# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'octopress-themekit/version'

Gem::Specification.new do |spec|
  spec.name          = "octopress-themekit"
  spec.version       = ThemeKit::VERSION
  spec.authors       = ["Brandon Mathis"]
  spec.email         = ["brandon@imathis.com"]
  spec.description   = %q{A starting point for creating gem-based Jekyll themes and plugins}
  spec.summary       = %q{A starting point for creating gem-based Jekyll themes and plugins}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "jekyll", "~> 1.3.0"
  spec.add_runtime_dependency "jekyll-page-hooks", "~> 1.1.0"
  spec.add_runtime_dependency "sass", "~> 3.2.0"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
