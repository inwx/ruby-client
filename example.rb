#!/usr/bin/env ruby
# frozen_string_literal: true

require 'inwx-domrobot'
require 'pp'

# Get your credentials from a safe place when using in production
user = ''
pass = ''

domrobot = INWX::Domrobot.new

result = domrobot.set_language('en').
         # use the OTE endpoint
         use_ote.
         # or use the LIVE endpoint instead
         # use_live.
         # use the JSON-RPC API
         use_json.
         # or use the XML-RPC API instead
         # use_xml.
         # output everything you're sending and receiving in JSON pretty print
         show_debug(true).
         # optional 3rd parameter available: shared_secret for 2 factor auth
         login(user, pass)

object = 'domain'
method = 'check'

params = { domain: 'mydomain.com' }

if result['code'] == 1000
  result = domrobot.call(object, method, params)

  domrobot.logout
end

pp result
