require 'test_helper'

class WasabbiAdminshipsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:wasabbi_adminships)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create wasabbi_adminship" do
    assert_difference('WasabbiAdminship.count') do
      post :create, :wasabbi_adminship => { }
    end

    assert_redirected_to wasabbi_adminship_path(assigns(:wasabbi_adminship))
  end

  test "should show wasabbi_adminship" do
    get :show, :id => wasabbi_adminships(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => wasabbi_adminships(:one).id
    assert_response :success
  end

  test "should update wasabbi_adminship" do
    put :update, :id => wasabbi_adminships(:one).id, :wasabbi_adminship => { }
    assert_redirected_to wasabbi_adminship_path(assigns(:wasabbi_adminship))
  end

  test "should destroy wasabbi_adminship" do
    assert_difference('WasabbiAdminship.count', -1) do
      delete :destroy, :id => wasabbi_adminships(:one).id
    end

    assert_redirected_to wasabbi_adminships_path
  end
end
