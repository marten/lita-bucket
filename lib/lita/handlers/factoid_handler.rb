module Lita
  module Handlers
    class FactoidHandler < Handler
      using Bucket::Refinements

      config :chance, default: 0.4

      # insert handler code here
      route(/^literal (?<trigger>.*)$/, :get, command: true)
      route(/^(?<trigger>.*) => (?<retort>.*)$/, :add, command: true)
      route(/^(?<trigger>.*)$/, :match, command: true)

      on :unhandled_message, :random_response

      def get(response)
        trigger = response.match_data[:trigger].strip
        retorts = factoids.match_all(trigger)

        if retorts.any?
          response.reply(retorts.map.with_index{|msg, idx| "[#{idx}] #{msg}"}.join("\n"))
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
        if retort = factoids.match_exact(response.message.body)
          vars = Bucket::Vars.new
          renderer = Bucket::Renderer.new(vars)
          response.reply(renderer.render(retort))
        end
      end

      def random_response(payload)
        return unless Bucket.random_generator.call < config.chance

        message = payload[:message]
        if retort = factoids.match(message.body)
          vars = Bucket::Vars.new
          renderer = Bucket::Renderer.new(vars)
          target = message.source
          robot.send_message(target, renderer.render(retort))
        end
      end

      def factoids
        @factoids ||= Bucket::Factoids.new
      end

      Lita.register_handler(self)
    end
  end
end
