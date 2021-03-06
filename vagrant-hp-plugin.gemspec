# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'vagrant-hp-plugin/version'

Gem::Specification.new do |gem|
  gem.name          = "vagrant-hp-plugin"
  gem.version       = VagrantPlugins::HP::VERSION
  gem.authors       = ["Mitchell Hashimoto", "Thomas Kadauke"]
  gem.email         = ["mitchell@hashicorp.com", "t.kadauke@cloudbau.de"]
  gem.description   = "Enables Vagrant to manage machines in HP Cloud."
  gem.summary       = "Enables Vagrant to manage machines in HP Cloud."
  gem.homepage      = "http://www.vagrantup.com"

  gem.add_runtime_dependency "fog", ">= 1.18.0"

  gem.add_development_dependency "rake"
  gem.add_development_dependency "rspec", "~> 2.13.0"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
