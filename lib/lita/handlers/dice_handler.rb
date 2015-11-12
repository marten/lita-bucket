module Lita
  module Handlers
    class DiceHandler < Handler
      using Bucket::Refinements

      route(/^roll (?<count>\d+)?d(?<sides>\d+)(?<additive>[+-]\d+)?(?<drop_lowest>-L)?$/i, :roll, command: true)

      def roll(response)
        count       = (response.match_data[:count] || "1")[0..-1].to_i
        sides       = (response.match_data[:sides] || "6").to_i
        additive    = (response.match_data[:additive] || "+0").to_i
        drop_lowest = (response.match_data[:drop_lowest])

        rollables = (1..sides).to_a
        rolls     = count.times.map { |_| rollables.sample }
        lowest    = drop_lowest ? rolls.min : 0
        total     = rolls.reduce(&:+) + additive - lowest

        case
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
