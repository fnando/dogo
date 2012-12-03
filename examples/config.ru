$:.unshift File.expand_path("../../lib", __FILE__)

require "dogo"

Dogo.host = "http://localhost:9292"
Dogo.api_key = "abc"
Dogo.default_url = "http://hellobits.com"

run Dogo::Server.new
