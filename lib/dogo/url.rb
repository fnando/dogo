module Dogo
  class Url
    attr_reader :full, :id

    # Check if the given URL is valid, according the the
    # +URI+ regular expression.
    def self.valid?(url)
      URI::DEFAULT_PARSER.regexp[:ABS_URI] =~ url.to_s
    end

    #
    #
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
