require 'test_helper'

class WasabbiThreadsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:wasabbi_threads)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create wasabbi_thread" do
    assert_difference('WasabbiThread.count') do
      post :create, :wasabbi_thread => { }
    end

    assert_redirected_to wasabbi_thread_path(assigns(:wasabbi_thread))
  end

  test "should show wasabbi_thread" do
    get :show, :id => wasabbi_threads(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => wasabbi_threads(:one).id
    assert_response :success
  end

  test "should update wasabbi_thread" do
    put :update, :id => wasabbi_threads(:one).id, :wasabbi_thread => { }
    assert_redirected_to wasabbi_thread_path(assigns(:wasabbi_thread))
  end

  test "should destroy wasabbi_thread" do
    assert_difference('WasabbiThread.count', -1) do
      delete :destroy, :id => wasabbi_threads(:one).id
    end

    assert_redirected_to wasabbi_threads_path
  end
end
