require 'test_helper'

class RutaControllerTest < ActionController::TestCase
  setup do
    @rutum = ruta(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ruta)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create rutum" do
    assert_difference('Rutum.count') do
      post :create, rutum: { ruta_descripcion: @rutum.ruta_descripcion, ruta_estadoRegistro: @rutum.ruta_estadoRegistro, ruta_frecuencia: @rutum.ruta_frecuencia, ruta_medio: @rutum.ruta_medio, ruta_vehiculo: @rutum.ruta_vehiculo }
    end

    assert_redirected_to rutum_path(assigns(:rutum))
  end

  test "should show rutum" do
    get :show, id: @rutum
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @rutum
    assert_response :success
  end

  test "should update rutum" do
    patch :update, id: @rutum, rutum: { ruta_descripcion: @rutum.ruta_descripcion, ruta_estadoRegistro: @rutum.ruta_estadoRegistro, ruta_frecuencia: @rutum.ruta_frecuencia, ruta_medio: @rutum.ruta_medio, ruta_vehiculo: @rutum.ruta_vehiculo }
    assert_redirected_to rutum_path(assigns(:rutum))
  end

  test "should destroy rutum" do
    assert_difference('Rutum.count', -1) do
      delete :destroy, id: @rutum
    end

    assert_redirected_to ruta_path
  end
end
