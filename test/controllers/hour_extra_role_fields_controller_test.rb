require 'test_helper'

class HourExtraRoleFieldsControllerTest < ActionController::TestCase
  setup do
    @hour_extra_role_field = hour_extra_role_fields(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:hour_extra_role_fields)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create hour_extra_role_field" do
    assert_difference('HourExtraRoleField.count') do
      post :create, hour_extra_role_field: { proposal_hour_id: @hour_extra_role_field.proposal_hour_id, role_hour_id.integer: @hour_extra_role_field.role_hour_id.integer }
    end

    assert_redirected_to hour_extra_role_field_path(assigns(:hour_extra_role_field))
  end

  test "should show hour_extra_role_field" do
    get :show, id: @hour_extra_role_field
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @hour_extra_role_field
    assert_response :success
  end

  test "should update hour_extra_role_field" do
    patch :update, id: @hour_extra_role_field, hour_extra_role_field: { proposal_hour_id: @hour_extra_role_field.proposal_hour_id, role_hour_id.integer: @hour_extra_role_field.role_hour_id.integer }
    assert_redirected_to hour_extra_role_field_path(assigns(:hour_extra_role_field))
  end

  test "should destroy hour_extra_role_field" do
    assert_difference('HourExtraRoleField.count', -1) do
      delete :destroy, id: @hour_extra_role_field
    end

    assert_redirected_to hour_extra_role_fields_path
  end
end
