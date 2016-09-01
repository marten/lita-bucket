module Bucket
  class Factoids
    attr_reader :redis

    def initialize
      @redis = Redis::Namespace.new('factoids', redis: Bucket.redis)
    end

    def add(trigger, retort)
      redis.sadd(normalize(trigger), retort)
    end

    def remove(trigger, retort)
      normalized_trigger = normalize(trigger)

      redis.srem(normalized_trigger, retort)
      if redis.scard(normalized_trigger) == 0
        redis.del(normalized_trigger)
      end
    end

    def match(message)
      triggers = redis.keys
      key = triggers.select {|trigger| matches?(normalize(trigger), normalize(message)) }.sample
      [key, redis.srandmember(key)]
    end

    def match_exact(message)
      redis.srandmember(normalize(message))
    end

    def match_all(message)
      redis.smembers(normalize(message))
    end

    private

    def matches?(trigger, msg)
      idx = msg.index(trigger)
      if idx
        pre = idx > 0 ? msg[idx-1] : nil
        post = msg[idx + trigger.length]
        word_boundary(pre) && word_boundary(post)
      end
    end

    def word_boundary(char)
      case char
      when nil then true
      when ' ' then true
      else false
      end
    end

    def normalize(message)
      message.downcase.gsub(/['"]/, '')
    end
  end
end
