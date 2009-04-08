$:.unshift 'test'
require 'test_helper'

class WasabbiForumsControllerTest < ActionController::TestCase
  def test_should_not_get_index_not_signed_in
    res = get :index
    assert_redirected_to :controller => 'user', :action => 'signin'
  end

  def test_should_not_get_index_not_super_admin
    res = get :index, {}, {:user => users(:music_admin).id}
    assert_redirected_to wasabbi_denied_admin_path
  end

  def test_should_get_index_super_admin
    get :index, {}, :user => users(:super_admin).id
    assert_response :success
    assert_not_nil assigns(:wasabbi_forums)
  end

  def test_should_not_get_index_norm
    get :index, {}, :user => users(:norm).id
    assert_redirected_to wasabbi_denied_admin_path
  end

  def test_should_get_new
    res = get :new, {
      :wasabbi_forum => {
        :parent_id => wasabbi_forums(:sports_category).id
      }},
      :user => users(:sports_admin)

    assert_not_nil assigns(:wasabbi_forum)

    tag = find_tag(:tag => "input", :attributes => {:name => "wasabbi_forum[parent_id]"})
    assert_equal tag['value'].to_i, wasabbi_forums(:sports_category).id

    assert_response :success
  end

  def test_should_not_get_new_not_logged_in
    get :new, {:parent_id => wasabbi_forums(:sports_category).id}
    assert_nil assigns(:wasabbi_forum)
    assert_redirected_to :controller => 'user', :action => 'signin'
  end

  def test_should_not_get_new_not_admin
    get :new, {:parent_id => wasabbi_forums(:sports_category).id},
      :user => users(:norm).id
    assert_nil assigns(:wasabbi_forum)
    assert_redirected_to wasabbi_denied_admin_path
  end

  def test_should_create_wasabbi_forum
    assert_difference('WasabbiForum.count') do
      post :create, {
        :wasabbi_forum => {
          :name => "Basketball",
          :description => "basketball forum",
          :parent_id => wasabbi_forums(:sports_category).id
        }
      }, :user => users(:sports_admin).id
    end

    assert_equal WasabbiForum.find_by_name("Basketball").parent,
      wasabbi_forums(:sports_category)

    assert_redirected_to wasabbi_forum_path(assigns(:wasabbi_forum))
  end

  def test_should_not_create_wasabbi_forum_norm
    assert_no_difference('WasabbiForum.count') do
      post :create, {
        :wasabbi_forum => {
          :parent_id => wasabbi_forums(:sports_category).id,
          :name => "Basketball",
          :description => "basketball forum"
        }
      }, :user => users(:norm).id
    end

    assert_nil WasabbiForum.find_by_name("Basketball")

    assert_redirected_to wasabbi_denied_admin_path
  end

  test "should not show forum not logged in members only" do
    get :show, {:id => wasabbi_forums(:thrash_metal).id}

    assert_response :redirect
    assert_redirected_to :controller => "user", :action => "signin"
  end

  test "should not show forum not member 1" do
    get :show, {:id => wasabbi_forums(:thrash_metal).id},
      :user => users(:norm).id

    assert_response :redirect
    assert_redirected_to wasabbi_denied_member_url
  end

  test "should not show forum not member 2" do
    get :show, {:id => wasabbi_forums(:secret_metal_forum).id},
      :user => users(:music_member_user).id

    assert_response :redirect
    assert_redirected_to wasabbi_denied_member_url
  end

  test "should show member 1" do
    get :show, {:id => wasabbi_forums(:thrash_metal).id},
      :user => users(:music_member_user).id

    assert_response :success
  end

  test "should show member 2" do
    get :show, {:id => wasabbi_forums(:secret_metal_forum).id},
      :user => users(:cool_guy_user).id

    assert_response :success
  end

  def test_should_show_wasabbi_forum
    get :show, {:id => wasabbi_forums(:sports_category).id}

    assert_response :success
  end
  def test_should_show_wasabbi_forum_admin
    get :show, {:id => wasabbi_forums(:sports_category).id},
      :user => users(:sports_admin).id

    assert_response :success
  end
  def test_should_show_wasabbi_forum_norm
    get :show, {:id => wasabbi_forums(:sports_category).id},
      :user => users(:norm).id

    assert_response :success
  end

  def test_should_get_edit
    get :edit, {:id => wasabbi_forums(:sports_category).id},
      :user => users(:sports_admin).id
    assert_response :success
  end

  def test_should_update_wasabbi_forum
    put :update, {:id => wasabbi_forums(:sports_category).id,
      :wasabbi_forum => { :name => "sportscat" }},
      :user => users(:sports_admin).id
    assert_redirected_to wasabbi_forum_path(assigns(:wasabbi_forum))
  end

  def test_should_destroy_wasabbi_forum
    assert_difference('WasabbiForum.count', -1) do
      delete :destroy, {:id => wasabbi_forums(:hockey).id},
        :user => users(:sports_admin).id
    end

    assert_redirected_to wasabbi_forums_path
  end
end
