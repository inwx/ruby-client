<p align="center">
  <a href="https://www.inwx.com/en/" target="_blank">
    <img src="https://www.inwx.com/images/logos/inwx.png">
  </a>
</p>

INWX Domrobot Ruby Client
=========
You can access all functions of our frontend via our API, which is available via the XML-RPC or JSON-RPC protocol and thus can be easily consumed with all programming languages.

There is also an OT&E test system, which you can access via [ote.inwx.com](https://ote.inwx.com/en/). Here you will find the known web interface which is using a test database. On the OT&E system no actions will be charged. So you can test as much as you like there.

Documentation
------
You can view a detailed description of the API functions in our documentation. You can find the online documentation [by clicking here](https://www.inwx.de/en/help/apidoc).

If you still experience any kind of problems don't hesitate to contact our [support via email](mailto:support@inwx.de).

Installation
-------

```bash
gem install inwx-domrobot
```

Example
-------

```ruby
require 'inwx-domrobot'
require 'pp'

user = ''
pass = ''

domrobot = INWX::Domrobot.new

result = domrobot.set_language('en').
         use_ote.
         use_json.
         set_debug(true).
         login(user, pass)

object = 'domain'
method = 'check'

params = { domain: 'mydomain.com' }

if result['code'] == 1000
  result = domrobot.call(object, method, params)

  domrobot.logout
end

pp result
```

You can also look at the example.rb in the Project.

License
----

MIT
