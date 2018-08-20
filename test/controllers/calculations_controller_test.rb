require 'test_helper'

class CalculationsControllerTest < ActionController::TestCase
  setup do
    @calculation = calculations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:calculations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create calculation" do
    assert_difference('Calculation.count') do
      post :create, calculation: { cofins: @calculation.cofins, csll: @calculation.csll, fgts: @calculation.fgts, incra: @calculation.incra, inss: @calculation.inss, irrf: @calculation.irrf, pis: @calculation.pis, salario_educacao: @calculation.salario_educacao, salario_minimo: @calculation.salario_minimo, sebrae: @calculation.sebrae, seguro_aci_trabalho: @calculation.seguro_aci_trabalho, senac: @calculation.senac, sesc: @calculation.sesc }
    end

    assert_redirected_to calculation_path(assigns(:calculation))
  end

  test "should show calculation" do
    get :show, id: @calculation
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @calculation
    assert_response :success
  end

  test "should update calculation" do
    patch :update, id: @calculation, calculation: { cofins: @calculation.cofins, csll: @calculation.csll, fgts: @calculation.fgts, incra: @calculation.incra, inss: @calculation.inss, irrf: @calculation.irrf, pis: @calculation.pis, salario_educacao: @calculation.salario_educacao, salario_minimo: @calculation.salario_minimo, sebrae: @calculation.sebrae, seguro_aci_trabalho: @calculation.seguro_aci_trabalho, senac: @calculation.senac, sesc: @calculation.sesc }
    assert_redirected_to calculation_path(assigns(:calculation))
  end

  test "should destroy calculation" do
    assert_difference('Calculation.count', -1) do
      delete :destroy, id: @calculation
    end

    assert_redirected_to calculations_path
  end
end
