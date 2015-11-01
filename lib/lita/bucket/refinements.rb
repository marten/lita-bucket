module Bucket
  module Refinements
    refine Array do
      def to_sentence(oxford_comma: true)
        case self.size
        when 0
          "nothing at all"
        when 1
          self[0]
        when 2
          self[0] + " and " + self[1]
        else
          self[0..-2].join(", ") + "#{oxford_comma ? ',' : ''} and " + self[-1]
        end
      end
    end
  end
end
