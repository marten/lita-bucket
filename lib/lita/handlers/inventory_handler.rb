module Lita
  module Handlers
    class InventoryHandler < Handler
      using Bucket::Refinements

      config :size, default: 5

      # insert handler code here
      route(/^take\s+(?<item>.+)/, :take)
      route(/^give me something/, :give, command: true)
      route(/^inventory\?/, :list, command: true)

      def take(response)
        item = response.match_data[:item].strip

        if inventory.has?(item)
          response.reply([
            "No thanks, I've already got one.",
            "I already have #{item}",
            "But I've already got #{item}!"
          ].sample)
        elsif dropped_item = inventory.add(item)
          response.reply([
            "drops #{dropped_item} and takes #{item}.",
            "is now carrying #{item}, but dropped #{dropped_item}"
          ].sample)
        else
          response.reply("takes #{item}.")
        end
      end

      def give(response)
        item = inventory.drop

        if item
          response.reply("gives <@#{response.user.id}> #{item}.")
        else
          response.reply("I'm empty!")
        end
      end

      def list(response)
        items = inventory.all

        if items.empty?
          response.reply("I'm empty!")
        else
          response.reply("contains #{items.to_sentence}.")
        end
      end

      private

      def inventory
        Bucket::Inventory.new
      end

      Lita.register_handler(self)
    end
  end
end
