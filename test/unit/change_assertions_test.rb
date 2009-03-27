$:.unshift 'test'
require 'test_helper'

class ChangeAssertionsTest < ActiveSupport::TestCase
  test "change and not changed" do
    to_i = proc {|i|i.to_i}
    to_s = proc {|i|i.to_s}

    a = ["10", "2", 5]

    assert_not_changed 'a.dup' do
      a.map(&to_i)
    end

    assert_changed 'a.dup' do
      a.map!(&to_i)
    end

    assert_changed 'a.dup' do
      a.map!(&to_s)
    end

    assert_not_changed 'a.dup' do
      a.map(&to_i)
    end
  end
end
