require 'test_helper'

class ProposalEquipamentsControllerTest < ActionController::TestCase
  setup do
    @proposal_equipament = proposal_equipaments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:proposal_equipaments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create proposal_equipament" do
    assert_difference('ProposalEquipament.count') do
      post :create, proposal_equipament: { equipament_id: @proposal_equipament.equipament_id, proposal_id: @proposal_equipament.proposal_id, quantidade: @proposal_equipament.quantidade }
    end

    assert_redirected_to proposal_equipament_path(assigns(:proposal_equipament))
  end

  test "should show proposal_equipament" do
    get :show, id: @proposal_equipament
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @proposal_equipament
    assert_response :success
  end

  test "should update proposal_equipament" do
    patch :update, id: @proposal_equipament, proposal_equipament: { equipament_id: @proposal_equipament.equipament_id, proposal_id: @proposal_equipament.proposal_id, quantidade: @proposal_equipament.quantidade }
    assert_redirected_to proposal_equipament_path(assigns(:proposal_equipament))
  end

  test "should destroy proposal_equipament" do
    assert_difference('ProposalEquipament.count', -1) do
      delete :destroy, id: @proposal_equipament
    end

    assert_redirected_to proposal_equipaments_path
  end
end
