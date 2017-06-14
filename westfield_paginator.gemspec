# coding: utf-8
require_relative 'lib/westfield_paginator/version'

Gem::Specification.new do |spec|
  spec.name          = 'westfield_paginator'
  spec.version       = Westfield::VERSION
  spec.authors       = ['Zhenya Mirkin', 'George Shaw']
  spec.email         = ['gshaw@westfield.com']

  spec.summary       = 'A common gem for pagination'
  spec.description   = 'A common gem for pagination'
  spec.homepage      = 'https://www.github.com/westfieldlabs/westfield_paginator'
  spec.license       = 'Apache 2.0'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 2.2.2'

  spec.add_dependency 'bundler'
  spec.add_dependency 'rake'
  spec.add_dependency 'kaminari'
  spec.add_dependency 'activesupport', '>= 4.2', '< 5.1'

  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'pry'
end
