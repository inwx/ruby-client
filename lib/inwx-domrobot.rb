# frozen_string_literal: true

require 'xmlrpc/client'
require 'json'
require 'net/http'
require 'net/https'
require 'rotp'

module INWX
  class Domrobot
    attr_accessor :client, :cookie, :language, :api_type, :url, :debug
    URL_LIVE = 'api.domrobot.com'
    URL_OTE = 'api.ote.domrobot.com'
    TYPE_JSON = '/jsonrpc/'
    TYPE_XML = '/xmlrpc/'
    private_constant :TYPE_JSON, :TYPE_XML, :URL_OTE, :URL_LIVE

    def initialize
      self.cookie = ''
      self.debug = false
      self.url = URL_OTE
      self.api_type = TYPE_JSON
    end

    def set_language(language = 'en')
      self.language = language
      self
    end

    def use_ote
      self.url = URL_OTE
      self
    end

    def use_live
      self.url = URL_LIVE
      self
    end

    def use_json
      self.api_type = TYPE_JSON
      self
    end

    def use_xml
      self.api_type = TYPE_XML
      self
    end

    def set_debug(value)
      self.debug = value
      self
    end

    def create_client
      if api_type == TYPE_XML
        self.client = XMLRPC::Client.new(url, api_type, '443', nil, nil, nil, nil, true, 100)
      else
        self.client = Net::HTTP.new(url, 443)
        client.use_ssl = true
      end
    end

    def login(username = false, password = false, shared_secret = nil)
      create_client

      params = { user: username, pass: password, lang: language }
      ret = call('account', 'login', params)

      unless shared_secret.nil?
        secret_code = get_secret_code(shared_secret)
        ret = call('account', 'unlock', tan: secret_code)
      end

      ret
    end

    def logout
      call('account', 'logout')
    end

    def call(object, method, params = {})
      if api_type == TYPE_XML
        call_xml(object, method, params)
      else
        call_json(object, method, params)
      end
    end

    def call_xml(object, method, params = {})
      client.cookie = cookie
      res = client.call(object + '.' + method, params)

      save_cookie(client.cookie)
      debug_sent = { method: object + '.' + method, params: params }
      output_debug(debug_sent.to_json, res.to_json)

      res
    end

    def call_json(object, method, params = {})
      req = Net::HTTP::Post.new(api_type)

      json_params = { method: object + '.' + method, params: params }

      req.body = json_params.to_json
      req['Cookie'] = cookie
      res = client.request(req)

      save_cookie(res.response['set-cookie'])
      output_debug(req.body, res.body)

      JSON.parse(res.body)
    end

    def save_cookie(cookie)
      self.cookie = cookie unless cookie.nil?
    end

    def output_debug(sent, received)
      if debug
        puts 'Sent:'
        puts JSON.pretty_generate(JSON.parse(sent))
        puts 'Received:'
        puts JSON.pretty_generate(JSON.parse(received))
        puts '-------------------------'
      end
    end

    def get_secret_code(shared_secret)
      totp = ROTP::TOTP.new(shared_secret)
      totp.now
    end
  end
end
