require 'test_helper'

class Admins::UsersControllerTest < ActionController::TestCase
  setup do
    @admins_user = admins_users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admins_users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create admins_user" do
    assert_difference('Admins::User.count') do
      post :create, admins_user: { access_level_ids: @admins_user.access_level_ids, department_ids: @admins_user.department_ids, direct_report_ids: @admins_user.direct_report_ids, email: @admins_user.email, first_name: @admins_user.first_name, last_name: @admins_user.last_name, phone: @admins_user.phone, position_ids: @admins_user.position_ids, postal_code: @admins_user.postal_code, practise_code_ids: @admins_user.practise_code_ids }
    end

    assert_redirected_to admins_user_path(assigns(:admins_user))
  end

  test "should show admins_user" do
    get :show, id: @admins_user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @admins_user
    assert_response :success
  end

  test "should update admins_user" do
    patch :update, id: @admins_user, admins_user: { access_level_ids: @admins_user.access_level_ids, department_ids: @admins_user.department_ids, direct_report_ids: @admins_user.direct_report_ids, email: @admins_user.email, first_name: @admins_user.first_name, last_name: @admins_user.last_name, phone: @admins_user.phone, position_ids: @admins_user.position_ids, postal_code: @admins_user.postal_code, practise_code_ids: @admins_user.practise_code_ids }
    assert_redirected_to admins_user_path(assigns(:admins_user))
  end

  test "should destroy admins_user" do
    assert_difference('Admins::User.count', -1) do
      delete :destroy, id: @admins_user
    end

    assert_redirected_to admins_users_path
  end
end
