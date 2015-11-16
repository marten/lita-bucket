module Bucket
  class Vars
    class GiveItem
      attr_reader :inventory

      def initialize(inventory = Inventory.new)
        @inventory = inventory
      end

      def all
        inventory.all
      end

      def size
        all.size
      end

      def sample
        inventory.drop
      end
    end
  end
end
