module Bucket
  class Vars
    def self.redis
      Redis::Namespace.new('vars', redis: Bucket.redis)
    end

    BUILTIN = {
      # Parts of speech
      # 'adjective' => Var.new(redis, 'adjective'),
      # 'adverb' => Var.new(redis, 'adverb'),
      # 'article' => Var.new(redis, 'article'),
      # 'noun' => Var.new(redis, 'noun'),
      # 'preposition' => Var.new(redis, 'preposition'),
      # 'verb' => Var.new(redis, 'verb'),

      # Places
      # 'country' => Var.new(redis, 'country'),
      'room' => Room.new,
      'place' => Place.new,

      # Things
      'bodypart' => Bodypart.new,
      # 'color' => Var.new(redis, 'color'),
      'gait' => Gait.new,
      'mood' => Mood.new,
      # 'occupation' => Var.new(redis, 'occupation'),
      'vehicle' => Vehicle.new,
      # 'weekday' => Var.new(redis, 'weekday'),

      # Critters
      'animal' => Animal.new,
      'pokemon' => Pokemon.new,

      # Numbers
      # 'digit' => Var.new(redis, 'digit'),
      # 'nonzero' => Var.new(redis, 'nonzero'),
      # 'hex' => Var.new(redis, 'hex')

      # Custom
      'thing' => Thing.new
    }

    attr_reader :vars

    def initialize(context = {})
      @vars = BUILTIN.merge(context)
    end

    def get(key)
      vars[key]
    end

    def list
      vars.keys.map {|i| "$#{i}" }
    end
  end
end
