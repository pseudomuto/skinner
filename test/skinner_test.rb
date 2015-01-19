require "test_helper"

class SkinnerTest < ActiveSupport::TestCase

  test ".hash_from_array parses a hash" do
    array = %(class: "field__input", required: true).split(",").map(&:strip)
    hash = Skinner.hash_from_array(array)
    assert_equal "field__input", hash[:class]
    assert hash[:required]
  end

  test ".hash_from_array can handle values with commas" do
    array = %(validations: "numeric, required", class: "field").split(",").map(&:strip)
    hash = Skinner.hash_from_array(array)
    assert_equal "numeric,required", hash[:validations]
    assert_equal "field", hash[:class]
  end
end
