require 'test_helper'

class ProposalRolesControllerTest < ActionController::TestCase
  setup do
    @proposal_role = proposal_roles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:proposal_roles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create proposal_role" do
    assert_difference('ProposalRole.count') do
      post :create, proposal_role: { proposal_id: @proposal_role.proposal_id, role_id: @proposal_role.role_id }
    end

    assert_redirected_to proposal_role_path(assigns(:proposal_role))
  end

  test "should show proposal_role" do
    get :show, id: @proposal_role
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @proposal_role
    assert_response :success
  end

  test "should update proposal_role" do
    patch :update, id: @proposal_role, proposal_role: { proposal_id: @proposal_role.proposal_id, role_id: @proposal_role.role_id }
    assert_redirected_to proposal_role_path(assigns(:proposal_role))
  end

  test "should destroy proposal_role" do
    assert_difference('ProposalRole.count', -1) do
      delete :destroy, id: @proposal_role
    end

    assert_redirected_to proposal_roles_path
  end
end
