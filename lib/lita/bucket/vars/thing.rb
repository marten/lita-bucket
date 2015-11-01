require_relative 'base'

module Bucket
  class Vars
    class Thing < RedisVar
      attr_reader :key

      def initialize
        @key = Inventory::HISTORY_KEY
      end

      def redis
        Inventory.redis
      end
    end
  end
end
