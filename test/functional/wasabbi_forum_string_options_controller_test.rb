require 'test_helper'

class WasabbiForumStringOptionsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:wasabbi_forum_string_options)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_wasabbi_forum_string_option
    assert_difference('WasabbiForumStringOption.count') do
      post :create, :wasabbi_forum_string_option => { :wasabbi_forum_id => wasabbi_forums(:one),
        :name => "somekey", :value => "somevalue"
      }
    end

    assert_redirected_to wasabbi_forum_string_option_path(assigns(:wasabbi_forum_string_option))
  end

  def test_should_show_wasabbi_forum_string_option
    get :show, :id => wasabbi_forum_string_options(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => wasabbi_forum_string_options(:one).id
    assert_response :success
  end

  def test_should_update_wasabbi_forum_string_option
    put :update, :id => wasabbi_forum_string_options(:one).id, :wasabbi_forum_string_option => { }
    assert_redirected_to wasabbi_forum_string_option_path(assigns(:wasabbi_forum_string_option))
  end

  def test_should_destroy_wasabbi_forum_string_option
    assert_difference('WasabbiForumStringOption.count', -1) do
      delete :destroy, :id => wasabbi_forum_string_options(:one).id
    end

    assert_redirected_to wasabbi_forum_string_options_path
  end
end
