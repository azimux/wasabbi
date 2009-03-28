$:.unshift('test')
require 'test_helper'

class WasabbiForumStringOptionTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "invalid option" do
    option = WasabbiForumStringOption.new(:name => "made up option",
      :value => "made up value")
    option.forum = wasabbi_forums(:metal_category)

    assert !option.valid?
  end

  test "valid option" do
    option = WasabbiForumStringOption.new(:name => "members_only",
      :value => "true")
    option.forum = wasabbi_forums(:metal_category)

    assert !wasabbi_forums(:metal_category).private_forum?
    assert wasabbi_forums(:thrash_metal).private_forum?
    assert wasabbi_forums(:retro_thrash).private_forum?

    assert_valid option
    assert option.valid?

    assert_difference('WasabbiForumStringOption.count') do
      assert option.save
    end

    assert wasabbi_forums(:metal_category).private_forum?
    assert wasabbi_forums(:thrash_metal).private_forum?
  end
end
