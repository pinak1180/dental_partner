require 'test_helper'

class Admins::ForumsControllerTest < ActionController::TestCase
  setup do
    @admins_forum = admins_forums(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admins_forums)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create admins_forum" do
    assert_difference('Admins::Forum.count') do
      post :create, admins_forum: { access_level_ids: @admins_forum.access_level_ids, department_ids: @admins_forum.department_ids, direct_report_ids: @admins_forum.direct_report_ids, expiry_date: @admins_forum.expiry_date, position_ids: @admins_forum.position_ids, practise_code_ids: @admins_forum.practise_code_ids, release_date: @admins_forum.release_date, subject: @admins_forum.subject, title: @admins_forum.title }
    end

    assert_redirected_to admins_forum_path(assigns(:admins_forum))
  end

  test "should show admins_forum" do
    get :show, id: @admins_forum
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @admins_forum
    assert_response :success
  end

  test "should update admins_forum" do
    patch :update, id: @admins_forum, admins_forum: { access_level_ids: @admins_forum.access_level_ids, department_ids: @admins_forum.department_ids, direct_report_ids: @admins_forum.direct_report_ids, expiry_date: @admins_forum.expiry_date, position_ids: @admins_forum.position_ids, practise_code_ids: @admins_forum.practise_code_ids, release_date: @admins_forum.release_date, subject: @admins_forum.subject, title: @admins_forum.title }
    assert_redirected_to admins_forum_path(assigns(:admins_forum))
  end

  test "should destroy admins_forum" do
    assert_difference('Admins::Forum.count', -1) do
      delete :destroy, id: @admins_forum
    end

    assert_redirected_to admins_forums_path
  end
end
