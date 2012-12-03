# Dogo

A simple URL shortener service backed by Redis.

## Installation

Add this line to your application"s Gemfile:

    gem "dogo"

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install dogo

## Usage

Set some options, like your API key and the host that will be used to compose the url.

``` ruby
Dogo.api_key = "abc"
Dogo.default_url = "http://hellobits.com"
Dogo.host = "http://fnando.me"
```

You can create shortened urls by using `Dogo::Url.new`.

```ruby
shortened = Dogo::Url.new("http://hellobits.com")
shortened.id    #=> return some an integer in base 36
shortened.url   #=> return the shortened url
shortened.full  #=> return full url
```

Starting the server:

``` ruby
require "dogo"
run Dogo::Server.new
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am "Add some feature"`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
