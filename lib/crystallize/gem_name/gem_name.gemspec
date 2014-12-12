require File.expand_path('../lib/{{gem_name}}/version', __FILE__)

Gem::Specification.new do |s|
  s.authors       = ['{{settings_name}}']
  s.email         = ['{{settings_email}}']
  s.description = s.summary = %q{TODO}
  s.homepage      = 'https://github.com/{{settings_github_username}}/{{gem_name}}'

  s.files         = `git ls-files`.split($\)
  s.name          = '{{gem_name}}'
  s.require_paths = ['lib']
  s.version       = {{gem_name_camelized}}::VERSION
  s.license       = 'MIT'

  s.add_development_dependency 'rspec'
end
