# -*- encoding: utf-8 -*-
require File.expand_path("../lib/indifferent_eval/version", __FILE__)

Gem::Specification.new do |gem|
  gem.name        = "indifferent_eval"
  gem.author      = "remi"
  gem.email       = "remi@remitaylor.com"
  gem.homepage    = "http://github.com/remi/indifferent_eval"
  gem.summary     = "Can't decide between instance_eval and block.call?  Why not support both!?"

  gem.description = <<-desc.gsub(/^\s+/, '')
    Can't decide between instance_eval and block.call?  Why not support both!?
  desc

  files = `git ls-files`.split("\n")
  gem.files         = files
  gem.executables   = files.grep(%r{^bin/.*}).map {|f| File.basename(f) }
  gem.test_files    = files.grep(%r{^spec/.*})
  gem.require_paths = ["lib"]
  gem.version       = IndifferentEval::VERSION

  gem.add_development_dependency "rake"
  gem.add_development_dependency "rspec"
end
