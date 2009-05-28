require 'test_helper'

class WasabbiRankTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "ranges" do
    [1,50,90,89].each do |count|
      assert_equal WasabbiRank.for_count(count), wasabbi_ranks(:noob)
    end

    [91,101,500,9999,10000,10001,10000000].each do |count|
      assert_equal WasabbiRank.for_count(count), wasabbi_ranks(:pro)
    end
  end
end
