$:.unshift 'test'
require 'test_helper'

class WasabbiThreadTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "can get to general forum via norms thread" do
    id1 = WasabbiThread.find(wasabbi_threads(:norms_thread).id).forum.id
    assert id1

    assert_equal id1, wasabbi_forums(:general_category).id
  end
end
