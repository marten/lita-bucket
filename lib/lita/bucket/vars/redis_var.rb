require_relative 'base'

module Bucket
  class Vars
    class RedisVar < Base
      attr_reader :key, :redis

      def initialize(key, redis)
        @key = key
        @redis = redis
      end

      def all
        redis.smembers(@key)
      end

      def size
        redis.scart(@key)
      end

      def sample
        redis.srandmember(@key)
      end
    end
  end
end
