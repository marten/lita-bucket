module Bucket
  class Renderer
    attr_reader :vars

    def initialize(vars)
      @vars = vars
    end

    def render(string)
      string.gsub(/\$(\w+)/) do |key|
        if var = vars.get($1)
          var.sample
        else
          key
        end
      end
    end
  end
end
