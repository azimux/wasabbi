$:.unshift 'test'
require 'test_helper'

class WasabbiAdminshipsControllerTest < ActionController::TestCase
  test "index not logged in" do
    wasabbi_adminships_path
    get :index
    assert_response :redirect
    assert_redirected_to :controller => "user", :action => "signin"
    assert_nil assigns(:wasabbi_adminships)
  end

  test "index nonadmin" do
    get :index, {}, {:user => users(:norm).id}
    assert_response :redirect
    assert_redirected_to wasabbi_denied_admin_path
    assert_nil assigns(:wasabbi_adminships)
  end

  test "index super admin" do
    get :index, {}, {:user => users(:super_admin).id}
    assert_response :success
    assert_not_nil assigns(:wasabbi_adminships)
  end

  test "index relevant admin" do
    get :index, {:forum_id => wasabbi_forums(:hockey).id}, {:user => users(:hockey_admin).id }
    assert_response :success
    assert_not_nil assigns(:wasabbi_adminships)
  end

  test "index relevant subadmin" do
    get :index, {:forum_id => wasabbi_forums(:hockey).id}, {:user => users(:sports_admin).id }
    assert_response :success
    assert_not_nil assigns(:wasabbi_adminships)
  end

  test "index irrelevant admin" do
    get :index, {}, {:user => users(:metal_admin).id}
    assert_response :redirect
    assert_redirected_to wasabbi_denied_admin_url
    assert_nil assigns(:wasabbi_adminships)
  end

  test "should get new" do
    get :new, {:forum_id => wasabbi_forums(:thrash_metal).id},
      :user => users(:music_admin).id
    assert_response :success
  end

  test "should create wasabbi_adminship" do
    assert_difference('WasabbiAdminship.count') do
      post :create, {
        :forum_id => wasabbi_forums(:thrash_metal).id,
        :wasabbi_adminship => {
          :wasabbi_user_id => wasabbi_users(:norm).id,
          :forum_id => wasabbi_forums(:thrash_metal).id
        }}, {:user => users(:music_admin).id}
    end

    assert_redirected_to wasabbi_adminship_path(assigns(:wasabbi_adminship))
  end

  test "should show wasabbi_adminship" do
    get :show, {:id => wasabbi_adminships(:metal_adminship).id,
      :forum_id => wasabbi_forums(:music_category).id},
      :user => users(:music_admin).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, {:id => wasabbi_adminships(:metal_adminship).id,
      :forum_id => wasabbi_forums(:thrash_metal).id},
      :user => users(:music_admin).id
    assert_response :success
  end

  test "should update wasabbi_adminship" do
    put :update, {:id => wasabbi_adminships(:metal_adminship).id, :wasabbi_adminship => {
        :is_subforum_admin => false }}, {:user => users(:super_admin).id}
    assert_redirected_to wasabbi_adminship_path(assigns(:wasabbi_adminship))
  end

  test "should destroy wasabbi_adminship" do
    assert_difference('WasabbiAdminship.count', -1) do
      delete :destroy, {:id => wasabbi_adminships(:metal_adminship).id},
        {:user => users(:super_admin).id}
    end

    assert_redirected_to wasabbi_adminships_path
  end
end
