require 'test_helper'

class AeropuertosControllerTest < ActionController::TestCase
  setup do
    @aeropuerto = aeropuertos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:aeropuertos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create aeropuerto" do
    assert_difference('Aeropuerto.count') do
      post :create, aeropuerto: { aeropt_ciudadCdg: @aeropuerto.aeropt_ciudadCdg, aeropt_codigoIATA: @aeropuerto.aeropt_codigoIATA, aeropt_estadoRegistro: @aeropuerto.aeropt_estadoRegistro, aeropt_nombre: @aeropuerto.aeropt_nombre }
    end

    assert_redirected_to aeropuerto_path(assigns(:aeropuerto))
  end

  test "should show aeropuerto" do
    get :show, id: @aeropuerto
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @aeropuerto
    assert_response :success
  end

  test "should update aeropuerto" do
    patch :update, id: @aeropuerto, aeropuerto: { aeropt_ciudadCdg: @aeropuerto.aeropt_ciudadCdg, aeropt_codigoIATA: @aeropuerto.aeropt_codigoIATA, aeropt_estadoRegistro: @aeropuerto.aeropt_estadoRegistro, aeropt_nombre: @aeropuerto.aeropt_nombre }
    assert_redirected_to aeropuerto_path(assigns(:aeropuerto))
  end

  test "should destroy aeropuerto" do
    assert_difference('Aeropuerto.count', -1) do
      delete :destroy, id: @aeropuerto
    end

    assert_redirected_to aeropuertos_path
  end
end
