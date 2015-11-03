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
      triggers = redis.keys
      puts triggers.inspect
      key = triggers.select {|trigger| message.include?(trigger) }.sample
      redis.srandmember(key)
    end

    def match_all(message)
      redis.smembers(message)
    end
  end
end
