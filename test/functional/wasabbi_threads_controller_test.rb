$:.unshift 'test'
require 'test_helper'

class WasabbiThreadsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index, :forum_id => wasabbi_forums(:hockey).id
    assert_response :success
    assert_not_nil assigns(:wasabbi_threads)
  end

  test "should not get index no forum" do
    assert_raise(Wasabbi::NoForumGiven) do
      get :index, {}, :user => users(:norm).id
    end

    assert_nil assigns(:wasabbi_threads)
  end

  test "should get new" do
    get :new, {:wasabbi_thread => {:forum_id => wasabbi_forums(:hockey).id}}, :user => users(:norm).id
    assert_response :success

    tag = find_tag(:tag => "input", :attributes => {:name => "wasabbi_thread[forum_id]"})
    assert_equal tag['value'].to_i, wasabbi_forums(:hockey).id
    assert wasabbi_forums(:hockey).id > 0
  end

  test "should not create wasabbi_thread bad attribute" do
    assert_no_difference('WasabbiThread.count') do
      assert_raise(ActiveRecord::IllegalMassAssignmentError) do
        post :create, {:wasabbi_thread => {
            :wasabbi_user_id => wasabbi_users(:cool_guy).id,
            :forum_id => wasabbi_forums(:hockey).id,
            :subject => "norm's second thread",
            :body => "here's the body!"
          }}, :user => users(:norm).id
      end
    end
  end

  test "should not create wasabbi_thread not logged in" do
    assert_no_difference('WasabbiThread.count') do
      post :create, :wasabbi_thread => {
        :subject => "norm's second thread",
        :body => "here's the body!"
      }
    end

    assert_redirected_to login_url
  end

  test "should create wasabbi_thread" do
    assert_difference(['WasabbiThread.count',
        'WasabbiUser.find(wasabbi_users(:norm).id).post_count']) do
      post :create, {
        :wasabbi_thread => {
          :forum_id => wasabbi_forums(:hockey).id,
          :subject => "norm's second thread",
          :body => "here's the body!"
        }}, :user => users(:norm).id
    end

    thread = WasabbiThread.find_by_subject("norm's second thread")

    assert thread

    post = WasabbiPost.find(:first,
      :conditions => "thread_id = #{thread.id}")

    assert post

    assert_equal post.subject, thread.subject

    assert_redirected_to wasabbi_thread_path(assigns(:wasabbi_thread))
  end

  test "should show wasabbi_thread" do
    #Let's make sure that the views got incremented
    assert_difference('WasabbiThread.find(wasabbi_threads(:norms_thread).id).views') do
      get :show, :id => wasabbi_threads(:norms_thread).id
      assert_response :success
    end
  end

  test "should show wasabbi_thread logged in" do
    #Let's make sure that the views got incremented
    assert_difference('WasabbiThread.find(wasabbi_threads(:norms_thread).id).views') do
      get :show, {
        :id => wasabbi_threads(:norms_thread).id
      }, :user => users(:norm).id
      assert_response :success
    end
  end

  test "should get edit" do
    get :edit, {:id => wasabbi_threads(:norms_thread).id},
      :user => users(:norm).id
    assert_response :success
  end

  test "should not update wasabbi_thread not logged in" do
    put :update, {:id => wasabbi_threads(:norms_thread).id, :wasabbi_thread => {
        :subject => wasabbi_threads(:norms_thread).subject + " modified" }}
    assert_redirected_to login_url
  end

  test "should not update wasabbi_thread" do
    put :update, {:id => wasabbi_threads(:norms_thread).id, :wasabbi_thread => {
        :subject => wasabbi_threads(:norms_thread).subject + " modified" }},
      :user => users(:norm).id

    assert_redirected_to wasabbi_thread_path(assigns(:wasabbi_thread))
  end

  test "should not destroy wasabbi_thread bad user" do
    #forum_id = wasabbi_threads(:norms_thread).forums.first.id

    assert_no_difference('WasabbiThread.count') do
      #forum_id = wasabbi_threads(:norms_thread).forums.first.id

      delete :destroy, {
        :id => wasabbi_threads(:norms_thread).id},
        :user => users(:cool_guy_user).id
    end

    assert_redirected_to wasabbi_denied_mod_url
  end

  test "should destroy wasabbi_thread" do
    assert_difference('WasabbiThread.count', -1) do
      #forum_id = wasabbi_threads(:norms_thread).forums.first.id
      delete :destroy, {
        :id => wasabbi_threads(:norms_thread).id},
        :user => users(:norm).id
    end

    assert_redirected_to wasabbi_threads_path
  end

  test "should not destroy wasabbi_thread has replies" do
    assert_no_difference('WasabbiThread.count') do
      #forum_id = wasabbi_threads(:norms_replied_to_thread).forums.first.id
      delete :destroy, {
        :id => wasabbi_threads(:norms_replied_to_thread).id},
        :user => users(:norm).id
    end

    assert_redirected_to wasabbi_thread_path(assigns(:wasabbi_thread))
    assert_equal flash[:error], "You can't delete threads that have been replied to."
  end
end
