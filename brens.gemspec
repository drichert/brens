# -*- encoding: utf-8 -*-
require File.expand_path('../lib/brens/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Dan Richert"]
  gem.email         = ["dan.richert@gmail.com"]
  gem.description   = %q{TODO: Brens is a text generator}
  gem.summary       = %q{TODO: Brens is a neural network based text generator}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "brens"
  gem.require_paths = ["lib"]
  gem.version       = Brens::VERSION
end
