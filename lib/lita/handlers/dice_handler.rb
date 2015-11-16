module Lita
  module Handlers
    class DiceHandler < Handler
      using Bucket::Refinements

      route(/^roll$/i, :default, command: true)
      route(/^roll (?<count>\d+)?d(?<sides>\d+)(?<additive>[+-]\d+)?(?<drop_lowest>-L)?$/i, :roll, command: true)

      def default(response)
        respond_to(response, count: 1, sides: 6, additive: 0, drop_lowest: false)
      end

      def roll(response)
        count       = (response.match_data[:count] || "1")[0..-1].to_i
        sides       = (response.match_data[:sides] || "6").to_i
        additive    = (response.match_data[:additive] || "+0").to_i
        drop_lowest = (response.match_data[:drop_lowest])
        respond_to(response, count: count, sides: sides, additive: additive, drop_lowest: drop_lowest)
      end

      def respond_to(response, count:, sides:, additive:, drop_lowest:)
        rollables = (1..sides).to_a
        rolls     = count.times.map { |_| rollables.sample }
        lowest    = drop_lowest ? rolls.min : 0
        total     = rolls.reduce(&:+) + additive - lowest

        case
        when sides == 1
          response.reply("Yeah, you can do the math on that one. I believe in you.")
        when rolls.size == 1 && drop_lowest
          response.reply("Don't be ridiculous. You wouldn't have anything left!")
        when rolls.size == 1 && additive == 0
          response.reply("Rolled #{rolls[0]}.")
        else
          reply = "Rolled #{rolls.map(&:to_s).to_sentence}"
          reply += ", dropped #{lowest}," if drop_lowest
          reply += " for a total of #{total}."
          response.reply(reply)
        end
      end

      Lita.register_handler(self)
    end
  end
end
