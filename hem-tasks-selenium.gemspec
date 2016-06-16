# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'hem/tasks/selenium/version'
require 'hem/url';

Gem::Specification.new do |spec|
  spec.name          = "hem-tasks-selenium"
  spec.version       = Hem::Tasks::Selenium::VERSION
  spec.authors       = ["Kit Kitson"]
  spec.email         = ["kkitson@inviqa.com"]

  spec.summary       = %q{Selenium tasks for Hem}
  spec.description   = %q{Selenium tasks for Hem}
  spec.homepage      = ""
  spec.licenses = ["MIT"]

  spec.files = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.require_paths = ["lib"]

  spec.add_dependency "ffi", "~> 1.9"
  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
end
