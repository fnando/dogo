$:.unshift File.expand_path("../../lib", __FILE__)

require "dogo"

Dogo.host        = "http://localhost:9292"
Dogo.api_key     = "abc"
Dogo.default_url = "http://hellobits.com"

# Alternative DSL to configure Dogo parameters
# Dogo.configure do |config|
#   config.host        = "http://localhost:9292"
#   config.api_key     = "abc"
#   config.default_url = "http://hellobits.com"
# end

run Dogo::Server.new
