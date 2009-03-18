require 'test_helper'

class WasabbiPostsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:wasabbi_posts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create wasabbi_post" do
    assert_difference('WasabbiPost.count') do
      post :create, :wasabbi_post => { }
    end

    assert_redirected_to wasabbi_post_path(assigns(:wasabbi_post))
  end

  test "should show wasabbi_post" do
    get :show, :id => wasabbi_posts(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => wasabbi_posts(:one).id
    assert_response :success
  end

  test "should update wasabbi_post" do
    put :update, :id => wasabbi_posts(:one).id, :wasabbi_post => { }
    assert_redirected_to wasabbi_post_path(assigns(:wasabbi_post))
  end

  test "should destroy wasabbi_post" do
    assert_difference('WasabbiPost.count', -1) do
      delete :destroy, :id => wasabbi_posts(:one).id
    end

    assert_redirected_to wasabbi_posts_path
  end
end
