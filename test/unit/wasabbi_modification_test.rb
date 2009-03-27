$:.unshift 'test'
require 'test_helper'

class WasabbiModificationTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "fixture quantity" do
    assert_equal wasabbi_modifications(:has_five).quantity, 5
  end

  test "default quantity" do
    assert_equal WasabbiModification.new.quantity, 0
  end
end
