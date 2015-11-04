require_relative 'base'

module Bucket
  class Vars
    class Who < Base
      attr_reader :key

      def initialize(user)
        @user = user
      end

      def all
        [@user.name]
      end

      def size
        all.size
      end

      def sample
        all.sample
      end
    end
  end
end
