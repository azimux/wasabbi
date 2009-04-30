$:.unshift 'test'
require 'test_helper'

class WasabbiUsersControllerTest < ActionController::TestCase
  def test_should_show_wasabbi_user
    get :show, {:id => wasabbi_users(:norm).id}

    assert_response :success
    assert_not_nil assigns(:wasabbi_user)

    assert_match(/Post count:?\s*(?:<[^>]*>\s*)*2\s*</i, @response.body)
  end
end
