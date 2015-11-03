module Lita
  module Handlers
    class VarHandler < Handler
      using Bucket::Refinements

      # insert handler code here
      route(/^var list/, :list, command: true)
      route(/^var \$(?<key>[a-zA-Z]+)$/, :get, command: true)
      route(/^var \$(?<key>[a-zA-Z]+) \+= (?<val>.+)/, :add, command: true)

      # Doesn't work, collides with other handlers
      # route(/^(?!(var)).+\$/i, :fill)

      def list(response)
        response.reply("I can fill in these variables: #{vars.list.sort.to_sentence}")
      end

      def get(response)
        key = response.match_data[:key].strip

        if var = vars.get(key)
          response.reply("You mean like a #{var.sample}?")
        else
          response.reply("That's not a real thing!")
        end
      end

      def add(response)
        key = response.match_data[:key].strip
        val = response.match_data[:val].strip

        if var = (vars.get(key) || vars.custom(key))
          if var.editable?
            var.add(val)
            response.reply("Sure, #{val} sounds like a #{key} to me.")
          else
            response.reply("I can't change that.")
          end
        else
          response.reply("That's not a real thing!")
        end
      end

      def fill(response)
        requested_vars = response.message.body.scan(/\$\w+/)

        if requested_vars.all? {|i| vars.list.include?(i) }
          renderer = Bucket::Renderer.new(vars)
          reply    = "yeah, " + renderer.render(response.message.body)
          response.reply(reply)
        end
      end

      private

      def vars
        @vars ||= Bucket::Vars.new
      end

      Lita.register_handler(self)
    end
  end
end
