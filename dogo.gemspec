# -*- encoding: utf-8 -*-
require "./lib/dogo/version"

Gem::Specification.new do |gem|
  gem.name          = "dogo"
  gem.version       = Dogo::VERSION
  gem.authors       = ["Nando Vieira"]
  gem.email         = ["fnando.vieira@gmail.com"]
  gem.description   = "A Redis-backed shortener url service."
  gem.summary       = gem.description

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency "redis"
  gem.add_dependency "sinatra"

  gem.add_development_dependency "pry"
  gem.add_development_dependency "awesome_print"
end
