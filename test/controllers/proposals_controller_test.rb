require 'test_helper'

class ProposalsControllerTest < ActionController::TestCase
  setup do
    @proposal = proposals(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:proposals)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create proposal" do
    assert_difference('Proposal.count') do
      post :create, proposal: { city_id: @proposal.city_id, cliente: @proposal.cliente, codigo_cliente: @proposal.codigo_cliente, equip_accessory_id: @proposal.equip_accessory_id, indice_retorno: @proposal.indice_retorno, intermunicipal: @proposal.intermunicipal, role_id: @proposal.role_id, rotation_id: @proposal.rotation_id, taxa_admin: @proposal.taxa_admin }
    end

    assert_redirected_to proposal_path(assigns(:proposal))
  end

  test "should show proposal" do
    get :show, id: @proposal
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @proposal
    assert_response :success
  end

  test "should update proposal" do
    patch :update, id: @proposal, proposal: { city_id: @proposal.city_id, cliente: @proposal.cliente, codigo_cliente: @proposal.codigo_cliente, equip_accessory_id: @proposal.equip_accessory_id, indice_retorno: @proposal.indice_retorno, intermunicipal: @proposal.intermunicipal, role_id: @proposal.role_id, rotation_id: @proposal.rotation_id, taxa_admin: @proposal.taxa_admin }
    assert_redirected_to proposal_path(assigns(:proposal))
  end

  test "should destroy proposal" do
    assert_difference('Proposal.count', -1) do
      delete :destroy, id: @proposal
    end

    assert_redirected_to proposals_path
  end
end
