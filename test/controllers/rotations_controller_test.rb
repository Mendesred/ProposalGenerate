require 'test_helper'

class RotationsControllerTest < ActionController::TestCase
  setup do
    @rotation = rotations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:rotations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create rotation" do
    assert_difference('Rotation.count') do
      post :create, rotation: { ad_noturno: @rotation.ad_noturno, ad_vespertido_noturno: @rotation.ad_vespertido_noturno, efetivo: @rotation.efetivo, fator_escala: @rotation.fator_escala, h_extra: @rotation.h_extra, h_extra_refeicao: @rotation.h_extra_refeicao, horas_trabalhadas: @rotation.horas_trabalhadas, period_id: @rotation.period_id, qtd_dias: @rotation.qtd_dias, tipo_escala: @rotation.tipo_escala }
    end

    assert_redirected_to rotation_path(assigns(:rotation))
  end

  test "should show rotation" do
    get :show, id: @rotation
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @rotation
    assert_response :success
  end

  test "should update rotation" do
    patch :update, id: @rotation, rotation: { ad_noturno: @rotation.ad_noturno, ad_vespertido_noturno: @rotation.ad_vespertido_noturno, efetivo: @rotation.efetivo, fator_escala: @rotation.fator_escala, h_extra: @rotation.h_extra, h_extra_refeicao: @rotation.h_extra_refeicao, horas_trabalhadas: @rotation.horas_trabalhadas, period_id: @rotation.period_id, qtd_dias: @rotation.qtd_dias, tipo_escala: @rotation.tipo_escala }
    assert_redirected_to rotation_path(assigns(:rotation))
  end

  test "should destroy rotation" do
    assert_difference('Rotation.count', -1) do
      delete :destroy, id: @rotation
    end

    assert_redirected_to rotations_path
  end
end
