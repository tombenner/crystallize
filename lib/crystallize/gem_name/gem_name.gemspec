require File.expand_path('../lib/gem_name/version', __FILE__)

Gem::Specification.new do |s|
  s.authors       = ['Tom Benner']
  s.email         = ['tombenner@gmail.com']
  s.description = s.summary = %q{TODO}
  s.homepage      = 'https://github.com/tombenner/gem_name'

  s.files         = `git ls-files`.split($\)
  s.name          = 'gem_name'
  s.require_paths = ['lib']
  s.version       = GemName::VERSION
  s.license       = 'MIT'

  s.add_development_dependency 'rspec'
end
