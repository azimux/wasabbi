require 'test_helper'

class WasabbiRanksControllerTest < ActionController::TestCase
  test "should not get index login" do
    get :index
    assert_redirected_to :controller => "user", :action => "signin"
  end

  test "should not get index admin" do
    get :index, {}, :user => users(:norm).id
    assert_redirected_to wasabbi_denied_admin_path
  end

  test "should get index" do
    get :index, {}, :user => users(:super_admin).id
    assert_response :success
    assert_not_nil assigns(:wasabbi_ranks)
  end

  test "should get new" do
    get :new, {}, :user => users(:super_admin).id
    assert_response :success
  end

  test "should not create wasabbi_rank login" do
    assert_no_difference('WasabbiRank.count') do
      post :create, :wasabbi_rank => { }
    end

    assert_redirected_to :controller => "user", :action => "signin"
  end

  test "should not create wasabbi_rank admin" do
    assert_no_difference('WasabbiRank.count') do
      post :create, {:wasabbi_rank => { }},
        :user => users(:norm).id
    end

    assert_redirected_to wasabbi_denied_admin_path
  end

  test "should create wasabbi_rank" do
    assert_difference('WasabbiRank.count') do
      post :create, {:wasabbi_rank => {
          :name => 'awesome',
          :lbound => 10001, :rbound => 1000000}},
        :user => users(:super_admin).id
    end

    assert_redirected_to wasabbi_rank_path(assigns(:wasabbi_rank))
  end

  test "should show wasabbi_rank" do
    get :show, {:id => wasabbi_ranks(:noob).id},
      :user => users(:super_admin).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, {:id => wasabbi_ranks(:noob).id},
      :user => users(:super_admin).id
    assert_response :success
  end

  test "should not update wasabbi_rank login" do
    put :update, :id => wasabbi_ranks(:noob).id,
      :wasabbi_rank => { :rbound => 100 }
    assert_redirected_to :controller => "user", :action => "signin"
  end

  test "should not destroy wasabbi_rank login" do
    assert_no_difference('WasabbiRank.count') do
      delete :destroy, :id => wasabbi_ranks(:noob).id
    end

    assert_redirected_to :controller => "user", :action => "signin"
  end

  test "should not update wasabbi_rank admin" do
    put :update, {:id => wasabbi_ranks(:noob).id,
      :wasabbi_rank => { :rbound => 100 }},
      :user => users(:norm).id
    assert_redirected_to wasabbi_denied_admin_path
  end

  test "should not destroy wasabbi_rank admin" do
    assert_no_difference('WasabbiRank.count') do
      delete :destroy, {:id => wasabbi_ranks(:noob).id},
        :user => users(:norm).id
    end

    assert_redirected_to wasabbi_denied_admin_path
  end

  test "should update wasabbi_rank" do
    assert_not_equal WasabbiRank.find_by_name('noob').rbound, 100

    put :update, {:id => wasabbi_ranks(:noob).id,
      :wasabbi_rank => { :rbound => 100 }},
      :user => users(:super_admin).id

    assert_redirected_to wasabbi_rank_path(assigns(:wasabbi_rank))

    assert_equal WasabbiRank.find_by_name('noob').rbound, 100
  end

  test "should destroy wasabbi_rank" do
    assert_difference('WasabbiRank.count', -1) do
      delete :destroy, {:id => wasabbi_ranks(:noob).id},
        :user => users(:super_admin).id
    end

    assert_redirected_to wasabbi_ranks_path
  end
end
