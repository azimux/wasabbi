$:.unshift 'test'
require 'test_helper'

class WasabbiForumsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:wasabbi_forums)
  end

  def test_should_get_index_admin
    get :index, {}, :user => users(:super_admin).id
    assert_response :success
    assert_not_nil assigns(:wasabbi_forums)
  end

  def test_should_get_index_norm
    get :index, {}, :user => users(:norm).id
    assert_response :success
    assert_not_nil assigns(:wasabbi_forums)
  end

  def test_should_get_new
    get :new, {:forum_id => wasabbi_forums(:sports_category).id},
      :user => users(:sports_admin)
    assert_not_nil assigns(:wasabbi_forum)
    assert_response :success
  end

  def test_should_not_get_new_not_logged_in
    get :new, {:forum_id => wasabbi_forums(:sports_category).id}
    assert_nil assigns(:wasabbi_forum)
    assert_redirected_to :controller => 'user', :action => 'signin'
  end

  def test_should_not_get_new_not_admin
    get :new, {:forum_id => wasabbi_forums(:sports_category).id},
      :user => users(:norm).id
    assert_nil assigns(:wasabbi_forum)
    assert_redirected_to wasabbi_denied_admin_path
  end

  def test_should_create_wasabbi_forum
    assert_difference('WasabbiForum.count') do
      post :create, {:forum_id => wasabbi_forums(:sports_category).id,
        :wasabbi_forum => {
          :name => "Basketball",
          :description => "basketball forum"
        }
      }, :user => users(:sports_admin).id
    end

    assert WasabbiForum.find_by_name("Basketball").parents.include?(
      wasabbi_forums(:sports_category)
    )

    assert_redirected_to wasabbi_forum_path(assigns(:wasabbi_forum))
  end

  def test_should_not_create_wasabbi_forum_norm
    assert_no_difference('WasabbiForum.count') do
      post :create, {:forum_id => wasabbi_forums(:sports_category).id,
        :wasabbi_forum => {
          :name => "Basketball",
          :description => "basketball forum"
        }
      }, :user => users(:norm).id
    end

    assert_nil WasabbiForum.find_by_name("Basketball")

    assert_redirected_to wasabbi_denied_admin_path
  end

  def test_should_show_wasabbi_forum
    get :show, {:id => wasabbi_forums(:sports_category).id}

    assert_response :success
  end
  def test_should_show_wasabbi_forum_admin
    get :show, {:id => wasabbi_forums(:sports_category).id},
      :user => users(:sports_admin).id

    assert_response :success
  end
  def test_should_show_wasabbi_forum_norm
    get :show, {:id => wasabbi_forums(:sports_category).id},
      :user => users(:norm).id

    assert_response :success
  end

  def test_should_get_edit
    get :edit, {:id => wasabbi_forums(:sports_category).id},
      :user => users(:sports_admin).id
    assert_response :success
  end

  def test_should_update_wasabbi_forum
    put :update, {:id => wasabbi_forums(:sports_category).id,
      :wasabbi_forum => { :name => "sportscat" }},
      :user => users(:sports_admin).id
    assert_redirected_to wasabbi_forum_path(assigns(:wasabbi_forum))
  end

  def test_should_destroy_wasabbi_forum
    assert_difference('WasabbiForum.count', -1) do
      delete :destroy, {:id => wasabbi_forums(:hockey).id},
        :user => users(:sports_admin).id
    end

    assert_redirected_to wasabbi_forums_path
  end
end
