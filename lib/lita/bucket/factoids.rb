module Bucket
  class Factoids
    attr_reader :redis

    def initialize
      @redis = Redis::Namespace.new('factoids', redis: Bucket.redis)
    end

    def add(trigger, retort)
      redis.sadd(trigger, retort)
    end

    def match(message)
      redis.srandmember(message)
    end

    def match_all(message)
      redis.smembers(message)
    end
  end
end
