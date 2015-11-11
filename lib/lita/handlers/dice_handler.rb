module Lita
  module Handlers
    class FactoidHandler < Handler
      using Bucket::Refinements

      route(/^roll (?<count>\d+d)?(?<sides>\d+)$/i, :roll, command: true)

      def roll(response)
        count = (response.match_data[:count] || "1d")[0..-2].to_i
        sides = (response.match_data[:sides] || "6").to_i
        rolls = count.times.map { |_| (1..sides).to_a.sample }

        response.reply("Rolled #{rolls.map(&:to_s).to_sentence} for a total of #{rolls.reduce(&:+)}")
      end

      Lita.register_handler(self)
    end
  end
end
