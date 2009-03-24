$:.unshift 'test'
require 'test_helper'

class WasabbiPostsControllerTest < ActionController::TestCase
  test "should not get index, no thread specified" do
    get :index, {}, {:user => users(:norm).id}
    assert_response :redirect
    assert_nil assigns(:wasabbi_posts)
  end

  test "should not get index not a member" do
    get :index, {:forum_id => wasabbi_forums(:football)}, {:user => users(:norm).id}
    assert_response :success
    assert_not_nil assigns(:wasabbi_posts)
  end

  test "should get index" do
    get :index, {:thread_id => wasabbi_threads(:norms_thread).id},
      {:user => users(:norm).id}
    assert_response :success
    assert_not_nil assigns(:wasabbi_posts)
  end

  test "should get new" do
    get :new, {}, :user => users(:norm).id
    assert_response :success
  end

  test "should create wasabbi_post" do
    assert_difference('WasabbiPost.count') do
      post :create, {:wasabbi_post => {
          :thread_id => wasabbi_threads(:norms_thread).id,
          :wasabbi_user_id => wasabbi_users(:norm).id,
          :subject => "subject2",
          :body => "this is the post's body."
        }}, :user => users(:norm).id
    end

    assert_redirected_to wasabbi_post_path(assigns(:wasabbi_post))
  end

  test "should show wasabbi_post" do
    get :show, {:id => wasabbi_posts(:norms_post).id}, :user => users(:norm).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, {:id => wasabbi_posts(:norms_post).id}, :user => users(:norm).id
    assert_response :success
  end

  test "should update wasabbi_post" do
    mods = wasabbi_posts(:norms_post).modifications
    put :update, {:id => wasabbi_posts(:norms_post).id, :wasabbi_post => {
        :modifications => wasabbi_posts(:norms_post).modifications + 1
      }}, :users => users(:norm).id
    assert mods != wasabbi_posts(:norms_post).modifications
    assert_redirected_to wasabbi_post_path(assigns(:wasabbi_post))
  end

  test "should destroy wasabbi_post" do
    assert_difference('WasabbiPost.count', -1) do
      delete :destroy, {:id => wasabbi_posts(:norms_post).id},
        :user => users(:super_admin).id
    end

    assert_redirected_to wasabbi_posts_path
  end
end
