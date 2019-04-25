Gem::Specification.new do |s|
  s.name     = 'name_of_person'
  s.version  = '1.1.1'
  s.authors  = 'David Heinemeier Hansson'
  s.email    = 'david@basecamp.com'
  s.summary  = 'Presenting names of people in full, familiar, abbreviated, and initialized forms (but without titulation etc)'
  s.homepage = 'https://github.com/basecamp/name_of_person'
  s.license  = 'MIT'

  s.required_ruby_version = '>= 2.4.0'

  s.add_dependency 'activesupport', '>= 5.2.0'

  s.add_development_dependency 'activemodel', '>= 5.2.0'
  s.add_development_dependency 'bundler', '~> 1.15'

  s.files      = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- test/*`.split("\n")
end
