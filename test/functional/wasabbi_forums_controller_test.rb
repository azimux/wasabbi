$:.unshift 'test'
require 'test_helper'

class WasabbiForumsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:wasabbi_forums)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_wasabbi_forum
    assert_difference('WasabbiForum.count') do
      post :create, :wasabbi_forum => { }
    end

    assert_redirected_to wasabbi_forum_path(assigns(:wasabbi_forum))
  end

  def test_should_show_wasabbi_forum
    get :show, :id => wasabbi_forums(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => wasabbi_forums(:one).id
    assert_response :success
  end

  def test_should_update_wasabbi_forum
    put :update, :id => wasabbi_forums(:one).id, :wasabbi_forum => { }
    assert_redirected_to wasabbi_forum_path(assigns(:wasabbi_forum))
  end

  def test_should_destroy_wasabbi_forum
    assert_difference('WasabbiForum.count', -1) do
      wasabbi_forums(:one).children.each do |c|
        c.parent = nil
        c.save!
      end
      delete :destroy, :id => wasabbi_forums(:one).id
    end

    assert_redirected_to wasabbi_forums_path
  end
end
