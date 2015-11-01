require_relative 'base'

module Bucket
  class Vars
    class Thing < RedisVar
      attr_reader :key, :redis

      def initialize
        @key = Inventory::HISTORY_KEY
        @redis = Inventory.redis
      end
    end
  end
end
