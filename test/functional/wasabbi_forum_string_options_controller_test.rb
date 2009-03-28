$:.unshift 'test'
require 'test_helper'

class WasabbiForumStringOptionsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index, {:forum_id => wasabbi_forums(:sports_category).id},
      :user => users(:sports_admin).id
    assert_response :success
    assert_not_nil assigns(:wasabbi_forum_string_options)
  end

  def test_should_get_new
    get :new, {:forum_id => wasabbi_forums(:sports_category).id},
      :user => users(:sports_admin).id
    assert_response :success
  end

  def test_should_not_create_wasabbi_forum_string_option
    assert_no_difference('WasabbiForumStringOption.count') do
      post :create, {:wasabbi_forum_string_option => {
          :forum_id => wasabbi_forums(:sports_category).id,
          :name => "somekey",
          :value => "somevalue"
        }}, :user => users(:norm).id
    end

    assert_nil assigns(:wasabbi_forum_string_option)
    assert_redirected_to wasabbi_denied_admin_url
  end

  def test_should_create_wasabbi_forum_string_option
    assert_difference('WasabbiForumStringOption.count') do
      post :create, {
        :forum_id => wasabbi_forums(:sports_category).id,
        :wasabbi_forum_string_option => {
          :forum_id => wasabbi_forums(:sports_category).id,
          :name => "members_only",
          :value => "false"
        }}, :user => users(:sports_admin).id
    end

    assert_redirected_to wasabbi_forum_string_option_path(assigns(:wasabbi_forum_string_option))
  end

  def test_should_show_wasabbi_forum_string_option
    get :show, {:id => wasabbi_forum_string_options(:theme_option).id,
      :forum_id => wasabbi_forums(:sports_category).id},
      :user => users(:sports_admin).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, {:id => wasabbi_forum_string_options(:theme_option).id,
      :forum_id => wasabbi_forums(:sports_category).id},
      :user => users(:sports_admin).id
    assert_response :success
  end

  def test_should_update_wasabbi_forum_string_option
    put :update, {:id => wasabbi_forum_string_options(:theme_option).id,
      :forum_id => wasabbi_forums(:sports_category).id,
      :wasabbi_forum_string_option => { :value => "default" }},
      :user => users(:sports_admin).id

    assert_redirected_to wasabbi_forum_string_option_path(assigns(:wasabbi_forum_string_option))
  end

  def test_should_destroy_wasabbi_forum_string_option
    assert_difference('WasabbiForumStringOption.count', -1) do
      delete :destroy, {:id => wasabbi_forum_string_options(:theme_option).id,
        :forum_id => wasabbi_forums(:sports_category).id
      }, :user => users(:sports_admin).id
    end

    assert_redirected_to wasabbi_forum_string_options_path
  end
end
