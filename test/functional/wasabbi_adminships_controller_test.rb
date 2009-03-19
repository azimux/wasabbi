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
      post :create, :wasabbi_adminship => { 
        :wasabbi_user_id => wasabbi_users(:norm).id,
        :forum_id => wasabbi_forums(:thrash_metal).id
      }
    end

    assert_redirected_to wasabbi_adminship_path(assigns(:wasabbi_adminship))
  end

  test "should show wasabbi_adminship" do
    get :show, :id => wasabbi_adminships(:metal_adminship).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => wasabbi_adminships(:metal_adminship).id
    assert_response :success
  end

  test "should update wasabbi_adminship" do
    put :update, :id => wasabbi_adminships(:metal_adminship).id, :wasabbi_adminship => {
      :is_subforum_admin => false }
    assert_redirected_to wasabbi_adminship_path(assigns(:wasabbi_adminship))
  end

  test "should destroy wasabbi_adminship" do
    assert_difference('WasabbiAdminship.count', -1) do
      delete :destroy, :id => wasabbi_adminships(:metal_adminship).id
    end

    assert_redirected_to wasabbi_adminships_path
  end
end
