require 'test_helper'

class ViewIncrementingTest < ActionController::IntegrationTest
  fixtures :all

  test "view incrementing" do
    thread = wasabbi_threads(:norms_thread)

    [
      {},
      {:referer => "http://asdfsdfdsf.googlebot.com"},
      {:referer => "httpasdfsdfdsf.googlebot.com"},
      {:referer => '#$#@#$@**(&*&!**&!#@*(!@()'},
    ].each do |hash|
      assert_difference('WasabbiThread.find(thread.id).views') do
        get wasabbi_thread_path(thread), nil, hash
        assert_response :success
      end
    end
  end

  test "view does not increment" do
    thread = wasabbi_threads(:norms_thread)

    [
      wasabbi_thread_path(thread),
      edit_wasabbi_thread_path(thread),
      new_wasabbi_thread_path(:wasabbi_thread => {:forum_id => thread.forum.id}),
    ].each do |ref|
      assert_no_difference('WasabbiThread.find(thread.id).views') do
        get wasabbi_thread_path(thread), nil, :referer => ref
        assert_response :success
      end
    end
  end
end
