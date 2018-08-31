require 'test_helper'

class SubTypesControllerTest < ActionController::TestCase
  setup do
    @sub_type = sub_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sub_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sub_type" do
    assert_difference('SubType.count') do
      post :create, sub_type: { name_sub_type: @sub_type.name_sub_type }
    end

    assert_redirected_to sub_type_path(assigns(:sub_type))
  end

  test "should show sub_type" do
    get :show, id: @sub_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @sub_type
    assert_response :success
  end

  test "should update sub_type" do
    patch :update, id: @sub_type, sub_type: { name_sub_type: @sub_type.name_sub_type }
    assert_redirected_to sub_type_path(assigns(:sub_type))
  end

  test "should destroy sub_type" do
    assert_difference('SubType.count', -1) do
      delete :destroy, id: @sub_type
    end

    assert_redirected_to sub_types_path
  end
end
