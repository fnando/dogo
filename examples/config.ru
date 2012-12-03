$:.unshift File.expand_path("../../lib", __FILE__)

require "dogo"

Dogo.api_key = "abc"
Dogo.default_url = "http://hellobits.com"

run Dogo::Server.new
