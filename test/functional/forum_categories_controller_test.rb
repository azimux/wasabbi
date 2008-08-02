$:.unshift 'test'
require 'test_helper'

class ForumCategoriesControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:forum_categories)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_forum_category
    assert_difference('ForumCategory.count') do
      post :create, :forum_category => { }
    end

    assert_redirected_to forum_category_path(assigns(:forum_category))
  end

  def test_should_show_forum_category
    get :show, :id => forum_categories(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => forum_categories(:one).id
    assert_response :success
  end

  def test_should_update_forum_category
    put :update, :id => forum_categories(:one).id, :forum_category => { }
    assert_redirected_to forum_category_path(assigns(:forum_category))
  end

  def test_should_destroy_forum_category
    assert_difference('ForumCategory.count', -1) do
      Forum.update_all("forum_category_id = NULL", "forum_category_id = #{forum_categories(:one).id}")
      Forum.update_all("parent_id = NULL", "parent_id = #{forum_categories(:one).id}")
      delete :destroy, :id => forum_categories(:one).id
    end

    assert_redirected_to forum_categories_path
  end
end
