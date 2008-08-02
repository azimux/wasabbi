require 'test_helper'

class ForumOptionsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:forum_options)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_forum_option
    assert_difference('ForumOption.count') do
      post :create, :forum_option => { }
    end

    assert_redirected_to forum_option_path(assigns(:forum_option))
  end

  def test_should_show_forum_option
    get :show, :id => forum_options(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => forum_options(:one).id
    assert_response :success
  end

  def test_should_update_forum_option
    put :update, :id => forum_options(:one).id, :forum_option => { }
    assert_redirected_to forum_option_path(assigns(:forum_option))
  end

  def test_should_destroy_forum_option
    assert_difference('ForumOption.count', -1) do
      delete :destroy, :id => forum_options(:one).id
    end

    assert_redirected_to forum_options_path
  end
end
