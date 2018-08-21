require 'test_helper'

class TypeEquipamentsControllerTest < ActionController::TestCase
  setup do
    @type_equipament = type_equipaments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:type_equipaments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create type_equipament" do
    assert_difference('TypeEquipament.count') do
      post :create, type_equipament: { equipament_id: @type_equipament.equipament_id, typeEquipament: @type_equipament.typeEquipament }
    end

    assert_redirected_to type_equipament_path(assigns(:type_equipament))
  end

  test "should show type_equipament" do
    get :show, id: @type_equipament
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @type_equipament
    assert_response :success
  end

  test "should update type_equipament" do
    patch :update, id: @type_equipament, type_equipament: { equipament_id: @type_equipament.equipament_id, typeEquipament: @type_equipament.typeEquipament }
    assert_redirected_to type_equipament_path(assigns(:type_equipament))
  end

  test "should destroy type_equipament" do
    assert_difference('TypeEquipament.count', -1) do
      delete :destroy, id: @type_equipament
    end

    assert_redirected_to type_equipaments_path
  end
end
