# Moip2

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'moip2'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install moip2

## Usage

To use the SDK follow these steps:

First you need to get your authentication using Basic or OAuth
```ruby
auth        = Moip2::Auth::Basic.new TOKEN, SECRET
```

```ruby
auth        = Moip2::Auth::OAuth.new OAuth
```

With your credentials properly created, chose an environment, the available options are :sandbox - for tests and integration - and :production. Keep in mind that your authentication changes according to the environment.
```ruby
client      = Moip2::Client.new :sandbox, auth
```
```ruby
invoice_api_client = Moip2::InvoiceApi.new client
```

## Contributing

1. Fork it ( http://github.com/<my-github-username>/moip2/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
