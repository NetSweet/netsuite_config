# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |s|
  s.name          = "netsuite_config"
  s.version       = '0.0.1'
  s.authors       = ["Michael Bianco"]
  s.email         = ["mike@suitesync.io"]
  s.summary       = %q{Manage your NetSuite configuration and SuiteScripts}
  s.homepage      = "http://github.com/netsweet/netsuite_config"
  s.license       = "MIT"

  s.files         = `git ls-files -z`.split("\x0")
  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|s|features)/})
  s.require_paths = ["lib"]

  s.add_dependency 'commander', '~> 4.4.3'
  s.add_dependency 'netsuite', '>= 0.7.7'
  s.add_dependency 'dotenv'

  s.add_development_dependency "bundler", "~> 1.7"
  s.add_development_dependency "rake", "~> 10.0"
end
