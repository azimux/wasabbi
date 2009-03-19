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
      post :create, :wasabbi_modship => {
        :wasabbi_user_id => wasabbi_users(:norm).id,
        :forum_id => wasabbi_forums(:thrash_metal).id
      }
    end

    assert_redirected_to wasabbi_modship_path(assigns(:wasabbi_modship))
  end

  test "should show wasabbi_modship" do
    get :show, :id => wasabbi_modships(:metal_modship).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => wasabbi_modships(:metal_modship).id
    assert_response :success
  end

  test "should update wasabbi_modship" do
    put :update, :id => wasabbi_modships(:metal_modship).id, :wasabbi_modship => {
      :is_subforum_mod => false
    }
    assert_redirected_to wasabbi_modship_path(assigns(:wasabbi_modship))
  end

  test "should destroy wasabbi_modship" do
    assert_difference('WasabbiModship.count', -1) do
      delete :destroy, :id => wasabbi_modships(:metal_modship).id
    end

    assert_redirected_to wasabbi_modships_path
  end
end
