$:.unshift 'test'
require 'test_helper'

class WasabbiRootForumTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "only one allowed" do
    assert WasabbiRootForum.count == 1

    WasabbiRootForum.delete_all

    assert WasabbiRootForum.count == 0

    WasabbiRootForum.create! :forum_id => wasabbi_forums(:top_level).id

    assert WasabbiRootForum.count == 1

    assert_raise WasabbiOnlyOneRootAllowedException do
      WasabbiRootForum.create(:forum_id => wasabbi_forums(:music_category).id)
    end

    assert WasabbiRootForum.count == 1

    assert_raise(WasabbiOnlyOneRootAllowedException) do
      WasabbiRootForum.create(:forum_id => wasabbi_forums(:music_category).id)
    end

    assert WasabbiRootForum.count == 1
  end
end
