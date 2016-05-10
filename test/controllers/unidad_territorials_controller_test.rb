require 'test_helper'

class UnidadTerritorialsControllerTest < ActionController::TestCase
  setup do
    @unidad_territorial = unidad_territorials(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:unidad_territorials)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create unidad_territorial" do
    assert_difference('UnidadTerritorial.count') do
      post :create, unidad_territorial: { undter_estadoRegistro: @unidad_territorial.undter_estadoRegistro, undter_nombre: @unidad_territorial.undter_nombre }
    end

    assert_redirected_to unidad_territorial_path(assigns(:unidad_territorial))
  end

  test "should show unidad_territorial" do
    get :show, id: @unidad_territorial
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @unidad_territorial
    assert_response :success
  end

  test "should update unidad_territorial" do
    patch :update, id: @unidad_territorial, unidad_territorial: { undter_estadoRegistro: @unidad_territorial.undter_estadoRegistro, undter_nombre: @unidad_territorial.undter_nombre }
    assert_redirected_to unidad_territorial_path(assigns(:unidad_territorial))
  end

  test "should destroy unidad_territorial" do
    assert_difference('UnidadTerritorial.count', -1) do
      delete :destroy, id: @unidad_territorial
    end

    assert_redirected_to unidad_territorials_path
  end
end
