module Dogo
  class Url
    attr_reader :full, :id

    # Rules for skipping url shortening.
    SKIP_RULES = [
      # Skip twitter urls
      -> url { url.match(%r{https://twitter.com/.+?/status/\d+}) }
    ]

    # Check if the given URL is valid, according the the
    # +URI+ regular expression.
    def self.valid?(url)
      URI::DEFAULT_PARSER.regexp[:ABS_URI] =~ url.to_s
    end

    # Check if the given URL is already shortened.
    # This will consider the host name and check if the url is already saved.
    def self.shortened?(url)
      url.start_with?(Dogo.host) &&
      find(url.split("/").last)
    end

    # Check if shortening must be skipped.
    # Useful for cases like twitter urls, so that inline embedding can work.
    def self.skip_shortening?(url)
      SKIP_RULES.any? {|rule| rule.call(url) }
    end

    # Find a URL by its shortened id.
    def self.find(id)
      key = Dogo.redis.keys("urls:*:#{id}").first
      return unless key

      new Dogo.redis.get(key)
    end

    def initialize(full)
      @full = full
      load_or_create
    end

    def url
      File.join(Dogo.host, id)
    end

    # Increment the click counter for this URL.
    def click!
      Dogo.redis.incr(click_key)
    end

    # Return the clicks for the current URL.
    def clicks
      Dogo.redis.get(click_key).to_i
    end

    private
    def click_key
      "clicks:#{id}"
    end

    def next_id
      Dogo.redis.incr("urls._id")
    end

    def load_or_create
      key = Dogo.redis.keys("urls:#{hash}:*").first

      if key
        @id = key.split(":").last
      else
        @id = next_id.to_s(36)
        Dogo.redis.set("urls:#{hash}:#{id}", full)
      end
    end

    def hash
      @hash ||= Digest::MD5.hexdigest(full)
    end
  end
end
