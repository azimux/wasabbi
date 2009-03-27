$:.unshift 'test'
require 'test_helper'

class WasabbiProblemsControllerTest < ActionController::TestCase
  test "should show problem default" do
    get :show, :message => "test message 3"

    assert_equal flash[:error], "test message 3"
    assert_nil flash[:notice]
    assert_nil flash[:warning]

    assert_response :success
    assert_match /test message 3/, @response.body  end

  test "should show problem notice" do
    get :show, :message => "test message 1", :level => "notice"

    assert_equal flash[:notice], "test message 1"
    assert_nil flash[:error]
    assert_nil flash[:warning]

    assert_response :success
    assert_match /test message 1/, @response.body
  end

  test "should show problem warning" do

    get :show, :message => "test message 2", :level => "warning"

    assert_equal flash[:warning], "test message 2"
    assert_nil flash[:error]
    assert_nil flash[:notice]

    assert_response :success
    assert_match /test message 2/, @response.body
  end

  test "should show problem error" do

    get :show, :message => "test message 3", :level => "error"

    assert_equal flash[:error], "test message 3"
    assert_nil flash[:notice]
    assert_nil flash[:warning]

    assert_response :success
    assert_match /test message 3/, @response.body
  end
end
