# API::FOM::Client

A example API client to LendKey FOM service. This utilizes `rsa_authority` gem to authorize with service.


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'api-fom-client'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install api-fom-client

## Usage

You will need a client id and a rsa key to sign the call.

Configure to point to the correct endpoints with your client id and location to pem key to sign the requests.
LendKey needs to know your client id and public key.

```ruby
API::FOM::Client::Configuration.configure do |config|
  config.private_key = 'my/private/key.pem'
  config.client_id = 'my-ca23dse'
  config.host = 'http://api.beybun.dev:3000'
end
```

Now you are ready to make calls to FOM service.


To find matching lenders in NJ, you need to make a call like this

```ruby
criteria = {state_codes: ['NJ']}
lender_ids = []
query = API::FOM::Client::Query.execute(criteria, :fom, lender_ids)

=> query.query_id
13

=> query.results
=> [#<API::FOM::Client::Result:0x007feb7d53a028 @lender_id=118, @reason="I live in NJ">]

```


## Contributing

1. Fork it ( https://github.com/metin/api-fom-client/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
