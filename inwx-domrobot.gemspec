# frozen_string_literal: true

Gem::Specification.new do |s|
  s.name                  = 'inwx-domrobot'
  s.version               = '4.0'
  s.date                  = '2023-05-01'
  s.summary               = 'INWX Domrobot'
  s.description           = 'Ruby Client to easily use the Domrobot API of INWX'
  s.authors               = ['INWX']
  s.email                 = 'support@inwx.de'
  s.files                 = ['lib/inwx_domrobot.rb']
  s.homepage              = 'https://rubygems.org/gems/inwx-domrobot'
  s.required_ruby_version = '>= 3.0.0'
  s.license               = 'MIT'

  s.add_runtime_dependency 'json', '~> 2.6.3', '>= 2.6.0'
  s.add_runtime_dependency 'rotp', '>= 6.2.2', '< 6.4.0'
  s.add_runtime_dependency 'xmlrpc', '~> 0.3.2', '>= 0.3.0'
end
