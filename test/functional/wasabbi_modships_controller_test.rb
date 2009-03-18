require 'test_helper'

class WasabbiModshipsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:wasabbi_modships)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create wasabbi_modship" do
    assert_difference('WasabbiModship.count') do
      post :create, :wasabbi_modship => { }
    end

    assert_redirected_to wasabbi_modship_path(assigns(:wasabbi_modship))
  end

  test "should show wasabbi_modship" do
    get :show, :id => wasabbi_modships(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => wasabbi_modships(:one).id
    assert_response :success
  end

  test "should update wasabbi_modship" do
    put :update, :id => wasabbi_modships(:one).id, :wasabbi_modship => { }
    assert_redirected_to wasabbi_modship_path(assigns(:wasabbi_modship))
  end

  test "should destroy wasabbi_modship" do
    assert_difference('WasabbiModship.count', -1) do
      delete :destroy, :id => wasabbi_modships(:one).id
    end

    assert_redirected_to wasabbi_modships_path
  end
end
