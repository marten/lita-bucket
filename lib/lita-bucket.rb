require "lita"

Lita.load_locales Dir[File.expand_path(
  File.join("..", "..", "locales", "*.yml"), __FILE__
)]

module Bucket
  def self.redis
    Redis::Namespace.new("handlers:bucket", redis: Lita.redis)
  end
end

require "lita/bucket/refinements"
require "lita/bucket/factoids"
require 'lita/bucket/inventory'

require "lita/bucket/vars/animal"
require "lita/bucket/vars/bodypart"
require "lita/bucket/vars/gait"
require "lita/bucket/vars/mood"
require "lita/bucket/vars/place"
require "lita/bucket/vars/pokemon"
require "lita/bucket/vars/redis_var"
require "lita/bucket/vars/room"
require "lita/bucket/vars/thing"
require "lita/bucket/vars/vehicle"
require "lita/bucket/vars"

require 'lita/bucket/renderer'

require "lita/handlers/inventory_handler"
require "lita/handlers/var_handler"
require 'lita/handlers/factoid_handler'

Lita::Handlers::InventoryHandler.template_root File.expand_path(
  File.join("..", "..", "templates"),
 __FILE__
)
