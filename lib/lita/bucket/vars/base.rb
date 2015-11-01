module Bucket
  class Vars
    class Base
      LIST = []

      def all
        self.class::LIST
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
