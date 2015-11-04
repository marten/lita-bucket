require "lita-bucket"
require "lita/rspec"
require 'pry-byebug'

# A compatibility mode is provided for older plugins upgrading from Lita 3. Since this plugin
# was generated with Lita 4, the compatibility mode should be left disabled.
Lita.version_3_compatibility_mode = false

Bucket.random_generator = lambda { 0.0 }
