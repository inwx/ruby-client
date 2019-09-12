Gem::Specification.new do |s|
    s.name        = 'inwx-domrobot'
    s.version     = '3.1'
    s.date        = '2019-09-12'
    s.summary     = "INWX Domrobot"
    s.description = "Ruby Client to easily use the Domrobot API of INWX"
    s.authors     = ["INWX"]
    s.email       = 'support@inwx.de'
    s.files       = ["lib/inwx-domrobot.rb"]
    s.homepage    = 'https://rubygems.org/gems/inwx-domrobot'
    s.add_runtime_dependency 'json', '~> 2.1', '>= 2.1.0'
    s.add_runtime_dependency 'xmlrpc', '~> 0.3', '>= 0.3.0'
    s.add_runtime_dependency 'rotp', '~> 5.1', '>= 5.1.0'
    s.license       = 'MIT'
  end
