require 'test_helper'

class Admins::NewsControllerTest < ActionController::TestCase
  setup do
    @admins_news = admins_news(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admins_news)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create admins_news" do
    assert_difference('Admins::News.count') do
      post :create, admins_news: {  }
    end

    assert_redirected_to admins_news_path(assigns(:admins_news))
  end

  test "should show admins_news" do
    get :show, id: @admins_news
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @admins_news
    assert_response :success
  end

  test "should update admins_news" do
    patch :update, id: @admins_news, admins_news: {  }
    assert_redirected_to admins_news_path(assigns(:admins_news))
  end

  test "should destroy admins_news" do
    assert_difference('Admins::News.count', -1) do
      delete :destroy, id: @admins_news
    end

    assert_redirected_to admins_news_index_path
  end
end
