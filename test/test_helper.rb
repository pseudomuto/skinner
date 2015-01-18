require "active_support"
require "active_support/core_ext/hash/keys"
require "minitest/autorun"
require "minitest/pride"
require "mocha/mini_test"
require "pry"
require "skinner"

class ActiveSupport::TestCase
  self.test_order = :random
end
