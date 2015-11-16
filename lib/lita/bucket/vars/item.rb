require_relative 'redis_var'

module Bucket
  class Vars
    class Item < RedisVar
      attr_reader :key

      def initialize
        @key = Inventory::CURRENT_KEY
      end

      def redis
        Inventory.redis
      end
    end
  end
end
