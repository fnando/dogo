require "redis"
require "uri"
require "digest/md5"
require "sinatra/base"

require "dogo/server"
require "dogo/url"
require "dogo/version"

module Dogo
  # Return the Redis connection.
  # If no connection has been set, connects
  # to localhost.
  def self.redis
    @redis ||= Redis.new
  end

  # Set the Redis connection.
  def self.redis=(redis)
    @redis = redis
  end

  class << self
    # Set the API Key that will be used to create new
    # URLs.
    attr_accessor :api_key

    # Set the default URL.
    # The `GET /` route will redirect to it.
    attr_accessor :default_url

    # Set the default host that will be
    # used to construct the shortened url.
    attr_accessor :host
  end
end
