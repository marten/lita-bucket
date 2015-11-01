module Lita
  module Handlers
    class FactoidHandler < Handler
      using Bucket::Refinements

      # insert handler code here
      route(/^literal (?<trigger>.*)$/, :get, command: true)
      route(/^(?<trigger>.*) => (?<retort>.*)$/, :add, command: true)
      route(/^.*$/, :match)

      def get(response)
        trigger = response.match_data[:trigger].strip
        retorts = factoids.match_all(trigger)

        if retorts.any?
          response.reply(retorts.join("\n"))
        else
          response.reply("Aint got a thing for that.")
        end
      end

      def add(response)
        trigger = response.match_data[:trigger].strip
        retort  = response.match_data[:retort].strip
        factoids.add(trigger, retort)
        response.reply("Okay.")
      end

      def match(response)
        if retort = factoids.match(response.message.body)
          vars = Bucket::Vars.new
          renderer = Bucket::Renderer.new(vars)
          response.reply(renderer.render(retort))
        end
      end

      def factoids
        @factoids ||= Bucket::Factoids.new
      end

      Lita.register_handler(self)
    end
  end
end
