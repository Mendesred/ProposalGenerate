require 'test_helper'

class ProposalHourExtrasControllerTest < ActionController::TestCase
  setup do
    @proposal_hour_extra = proposal_hour_extras(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:proposal_hour_extras)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create proposal_hour_extra" do
    assert_difference('ProposalHourExtra.count') do
      post :create, proposal_hour_extra: { admin_id: @proposal_hour_extra.admin_id, city_id: @proposal_hour_extra.city_id, client: @proposal_hour_extra.client, company_id: @proposal_hour_extra.company_id, local: @proposal_hour_extra.local, rotation_id: @proposal_hour_extra.rotation_id }
    end

    assert_redirected_to proposal_hour_extra_path(assigns(:proposal_hour_extra))
  end

  test "should show proposal_hour_extra" do
    get :show, id: @proposal_hour_extra
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @proposal_hour_extra
    assert_response :success
  end

  test "should update proposal_hour_extra" do
    patch :update, id: @proposal_hour_extra, proposal_hour_extra: { admin_id: @proposal_hour_extra.admin_id, city_id: @proposal_hour_extra.city_id, client: @proposal_hour_extra.client, company_id: @proposal_hour_extra.company_id, local: @proposal_hour_extra.local, rotation_id: @proposal_hour_extra.rotation_id }
    assert_redirected_to proposal_hour_extra_path(assigns(:proposal_hour_extra))
  end

  test "should destroy proposal_hour_extra" do
    assert_difference('ProposalHourExtra.count', -1) do
      delete :destroy, id: @proposal_hour_extra
    end

    assert_redirected_to proposal_hour_extras_path
  end
end
