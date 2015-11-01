module Bucket
  class Inventory
    CURRENT_KEY = "current"
    HISTORY_KEY = "history"

    attr_reader :size

    def initialize(size: 5)
      @size = size
    end

    def add(item)
      if self.class.redis.scard(CURRENT_KEY) >= size
        dropped_item = drop
      end

      self.class.redis.sadd(CURRENT_KEY, item)
      self.class.redis.sadd(HISTORY_KEY, item)
      dropped_item
    end

    def drop
      self.class.redis.srandmember(CURRENT_KEY).tap do |item|
        self.class.redis.srem(CURRENT_KEY, item)
      end
    end

    def sample
      self.class.redis.srandmember(CURRENT_KEY)
    end

    def has?(item)
      self.class.redis.sismember(CURRENT_KEY, item)
    end

    def all
      self.class.redis.smembers(CURRENT_KEY)
    end

    def self.redis
      @redis = Redis::Namespace.new('inventory', redis: Bucket.redis)
    end
  end
end
