require 'test_helper'

class EquipamentsControllerTest < ActionController::TestCase
  setup do
    @equipament = equipaments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:equipaments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create equipament" do
    assert_difference('Equipament.count') do
      post :create, equipament: { depreciacao: @equipament.depreciacao, name_equipament: @equipament.name_equipament, proposal_id: @equipament.proposal_id, valor: @equipament.valor }
    end

    assert_redirected_to equipament_path(assigns(:equipament))
  end

  test "should show equipament" do
    get :show, id: @equipament
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @equipament
    assert_response :success
  end

  test "should update equipament" do
    patch :update, id: @equipament, equipament: { depreciacao: @equipament.depreciacao, name_equipament: @equipament.name_equipament, proposal_id: @equipament.proposal_id, valor: @equipament.valor }
    assert_redirected_to equipament_path(assigns(:equipament))
  end

  test "should destroy equipament" do
    assert_difference('Equipament.count', -1) do
      delete :destroy, id: @equipament
    end

    assert_redirected_to equipaments_path
  end
end
