require 'test_helper'

class WasabbiGroupsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:wasabbi_groups)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create wasabbi_group" do
    assert_difference('WasabbiGroup.count') do
      post :create, :wasabbi_group => {
        :name => "Metal Members",
        :forum_id => wasabbi_forums(:metal_category).id
      }
    end

    assert_redirected_to wasabbi_group_path(assigns(:wasabbi_group))
  end

  test "should show wasabbi_group" do
    get :show, :id => wasabbi_groups(:football_group).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => wasabbi_groups(:football_group).id
    assert_response :success
  end

  test "should update wasabbi_group" do
    put :update, :id => wasabbi_groups(:football_group).id, :wasabbi_group => { }
    assert_redirected_to wasabbi_group_path(assigns(:wasabbi_group))
  end

  test "should destroy wasabbi_group" do
    assert_difference('WasabbiGroup.count', -1) do
      delete :destroy, :id => wasabbi_groups(:football_group).id
    end

    assert_redirected_to wasabbi_groups_path
  end
end
