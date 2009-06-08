$:.unshift 'test'
require 'test_helper'

class WasabbiPostsControllerTest < ActionController::TestCase
  test "should not get index not a member" do
    get :index, {:thread_id => wasabbi_threads(:secret_thread)}, {:user => users(:norm).id}
    assert_nil assigns(:wasabbi_posts)
    assert_redirected_to wasabbi_denied_member_path
  end

  test "should get index is a member" do
    get :index, {:thread_id => wasabbi_threads(:secret_thread)}, {:user => users(:cool_guy_user).id}
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
    get :new, {:wasabbi_post => {:thread_id => wasabbi_threads(:norms_thread).id}}, :user => users(:norm).id
    assert_response :success
    assert_not_nil assigns(:wasabbi_post)
  end

  test "should not get new not member" do
    get :new, {:thread_id => wasabbi_threads(:secret_thread).id}, :user => users(:norm).id
    assert_nil assigns(:wasabbi_posts)
    assert_redirected_to wasabbi_denied_member_path
  end

  test "should get new is member" do
    get :new, {:wasabbi_post => {:thread_id => wasabbi_threads(:secret_thread).id}},
      :user => users(:cool_guy_user).id
    assert_response :success
    assert_not_nil assigns(:wasabbi_post)
  end

  test "should create wasabbi_post" do
    assert_difference(['WasabbiPost.count',
        'WasabbiUser.find(wasabbi_users(:norm).id).post_count']) do
      post :create, {:wasabbi_post => {
          :thread_id => wasabbi_threads(:norms_thread).id,
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
    test_exps = ['WasabbiPost.find(wasabbi_posts(:norms_post).id).subject',
      'WasabbiPost.find(wasabbi_posts(:norms_post).id).total_modifications']

    assert_not_changed test_exps do
      true
    end

    assert_changed(test_exps) do
      put :update, {:id => wasabbi_posts(:norms_post).id, :wasabbi_post => {
          :subject => "subject changed"
        }}, :user => users(:norm).id

      assert_response :redirect
      assert_redirected_to wasabbi_post_path(wasabbi_posts(:norms_post).id)
    end
  end

  test "should destroy wasabbi_post super admin" do
    thread = wasabbi_posts(:norms_post).thread

    assert_difference('WasabbiPost.count', -1) do
      delete :destroy, {:id => wasabbi_posts(:norms_post).id},
        :user => users(:super_admin).id
    end

    assert_redirected_to thread
  end

  test "should destroy wasabbi_post owner" do
    thread = wasabbi_posts(:norms_post).thread

    assert_difference('WasabbiPost.count', -1) do
      delete :destroy, {:id => wasabbi_posts(:norms_post).id},
        :user => users(:norm).id
    end

    assert_redirected_to thread
  end

  test "should not destroy wasabbi_post not owner" do
    assert_no_difference('WasabbiPost.count', -1) do
      delete :destroy, {:id => wasabbi_posts(:norms_post).id},
        :user => users(:cool_guy_user).id
    end

    assert_redirected_to wasabbi_denied_mod_path
  end
end
