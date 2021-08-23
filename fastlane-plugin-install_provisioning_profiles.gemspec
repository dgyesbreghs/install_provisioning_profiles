# coding: utf-8

lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fastlane/plugin/install_provisioning_profiles/version'

Gem::Specification.new do |spec|
  spec.name          = 'fastlane-plugin-install_provisioning_profiles'
  spec.version       = Fastlane::InstallProvisioningProfiles::VERSION
  spec.author        = 'Dylan Gyesbreghs'
  spec.email         = 'dgyesbreghs@gmail.com'

  spec.summary       = "Install all the provisioning profiles located in you're project."
  spec.homepage      = "https://github.com/dgyesbreghs/install_provisioning_profiles"
  spec.license       = "MIT"

  # Only with ruby 2.0.x
  spec.required_ruby_version = '>= 2.0'

  spec.files         = Dir["lib/**/*"] + %w(README.md LICENSE)
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rspec_junit_formatter'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rubocop', '0.49.1'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'fastlane', '>= 2.64.1'
end
