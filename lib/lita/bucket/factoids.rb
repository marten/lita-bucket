module Bucket
  class Factoids
    attr_reader :redis

    def initialize
      @redis = Redis::Namespace.new('factoids', redis: Bucket.redis)
    end

    def add(trigger, retort)
      redis.sadd(normalize(trigger), retort)
    end

    def match(message)
      normalized_message = normalize(message)
      triggers = redis.keys
      key = triggers.select {|trigger| normalized_message =~ /\b#{normalize(trigger)}\b/ }.sample
      redis.srandmember(key)
    end

    def match_exact(message)
      normalized_message = normalize(message)
      redis.srandmember(normalized_message)
    end

    def match_all(message)
      normalized_message = normalize(message)
      redis.smembers(normalized_message)
    end

    def normalize(message)
      message.downcase.gsub(/['"]/, '')
    end
  end
end
