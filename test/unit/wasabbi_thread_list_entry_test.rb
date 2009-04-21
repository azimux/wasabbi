$:.unshift 'test'
require 'test_helper'

class WasabbiThreadListEntryTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "forum and thread can be reached correctly" do
    tle = wasabbi_thread_list_entries(:one)

    assert_equal tle.thread.id, wasabbi_threads(:norms_thread).id
    assert_equal tle.forum.id, wasabbi_forums(:general_forum).id
  end
end
