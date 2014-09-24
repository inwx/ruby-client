#!/usr/bin/env ruby
require "./inwx/Domrobot"
require "yaml"

addr = "api.ote.domrobot.com"
# addr = "api.domrobot.com"
user = "your_username"
pass = "your_password"

domrobot = INWX::Domrobot.new(addr)

result = domrobot.login(user,pass)
puts YAML::dump(result)

object = "domain"
method = "check"

params = { :domain => "mydomain.com" }

result = domrobot.call(object, method, params)

puts YAML::dump(result)
