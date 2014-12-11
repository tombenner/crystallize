require File.expand_path('../lib/crystallize/version', __FILE__)

Gem::Specification.new do |s|
  s.authors       = ['Tom Benner']
  s.email         = ['tombenner@gmail.com']
  s.description = s.summary = %q{Generate gems!}
  s.homepage      = 'https://github.com/tombenner/crystallize'

  s.files         = `git ls-files`.split($\)
  s.name          = 'crystallize'
  s.executables   = ['crystallize']
  s.require_paths = ['lib']
  s.version       = Crystallize::VERSION
  s.license       = 'MIT'

  s.add_development_dependency 'rspec'
end
