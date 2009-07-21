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
    assert_equal WasabbiThread.find(wasabbi_threads(:norms_thread).id).replies,
      wasabbi_threads(:norms_thread).replies

    assert_difference(['WasabbiPost.count',
        'WasabbiUser.find(wasabbi_users(:norm).id).post_count',
        'WasabbiThread.find(wasabbi_threads(:norms_thread).id).replies'
      ]) do
      post :create, {:wasabbi_post => {
          :thread_id => wasabbi_threads(:norms_thread).id,
          :subject => "subject2",
          :body => "this is the post's body."
        }}, :user => users(:norm).id
    end

    assert_redirected_to wasabbi_thread_path(assigns(:wasabbi_post).thread,
      :post_id => assigns(:wasabbi_post).id)
  end

  test "should create wasabbi_post in replied to" do
    assert_equal WasabbiThread.find(wasabbi_threads(:norms_replied_to_thread).id).replies,
      wasabbi_threads(:norms_replied_to_thread).replies

    assert_difference(['WasabbiPost.count',
        'WasabbiUser.find(wasabbi_users(:norm).id).post_count',
        'WasabbiThread.find(wasabbi_threads(:norms_replied_to_thread).id).replies'
      ]) do
      post :create, {:wasabbi_post => {
          :thread_id => wasabbi_threads(:norms_replied_to_thread).id,
          :subject => "subject2",
          :body => "this is the post's body."
        }}, :user => users(:norm).id
    end

    assert_redirected_to wasabbi_thread_path(assigns(:wasabbi_post).thread,
      :post_id => assigns(:wasabbi_post).id)
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
      assert_redirected_to wasabbi_thread_path(wasabbi_posts(:norms_post).thread.id,
        :post_id => wasabbi_posts(:norms_post).id)
    end
  end

  test "should destroy wasabbi_post super admin" do
    post = wasabbi_posts(:norms_post)
    thread = post.thread

    assert_difference('WasabbiPost.count', -1) do
      delete :destroy, {:id => post.id},
        :user => users(:super_admin).id
    end

    assert_redirected_to wasabbi_thread_url(thread, :post_id => post.id)
  end

  test "should destroy wasabbi_post owner" do
    post = wasabbi_posts(:norms_post)
    thread = post.thread

    assert_difference('WasabbiPost.count', -1) do
      delete :destroy, {:id => post.id},
        :user => users(:norm).id
    end

    #make sure the thread has been deleted as well
    assert_raise ActiveRecord::RecordNotFound do
      assert_not_nil WasabbiThread.find(thread.id)
    end

    assert_redirected_to wasabbi_thread_url(thread, :post_id => post.id)
  end

  test "should not destroy wasabbi_post not owner" do
    assert_no_difference('WasabbiPost.count', -1) do
      delete :destroy, {:id => wasabbi_posts(:norms_post).id},
        :user => users(:cool_guy_user).id
    end

    assert_redirected_to wasabbi_denied_mod_path
  end

  test "should not destroy wasabbi_post not last" do
    post = wasabbi_posts(:norms_replied_to_post)
    thread = post.thread

    assert_no_difference('WasabbiPost.count', -1) do
      delete :destroy, {:id => post.id},
        :user => users(:norm).id
    end

    assert_redirected_to wasabbi_not_last_path(:post_id => post.id)
  end

  test "should destroy wasabbi_post is last" do
    post = wasabbi_posts(:cool_guys_reply)
    thread = post.thread

    assert_difference('WasabbiPost.count', -1) do
      delete :destroy, {:id => post.id},
        :user => users(:cool_guy_user).id
    end

    assert_redirected_to wasabbi_thread_url(thread, :post_id => post.id)
  end
end
