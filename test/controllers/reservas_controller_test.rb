require 'test_helper'

class ReservasControllerTest < ActionController::TestCase
  setup do
    @reserva = reservas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:reservas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create reserva" do
    assert_difference('Reserva.count') do
      post :create, reserva: { created_by: @reserva.created_by, rsrv_codigo: @reserva.rsrv_codigo, rsrv_contactoId: @reserva.rsrv_contactoId, rsrv_estado: @reserva.rsrv_estado, rsrv_fechaVencimiento: @reserva.rsrv_fechaVencimiento, rsrv_productoId: @reserva.rsrv_productoId, rsrv_solicitanteId: @reserva.rsrv_solicitanteId, rsrv_tipoContacto: @reserva.rsrv_tipoContacto, rsrv_tipoProducto: @reserva.rsrv_tipoProducto, rsrv_tipoSolicitante: @reserva.rsrv_tipoSolicitante, updated_by: @reserva.updated_by }
    end

    assert_redirected_to reserva_path(assigns(:reserva))
  end

  test "should show reserva" do
    get :show, id: @reserva
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @reserva
    assert_response :success
  end

  test "should update reserva" do
    patch :update, id: @reserva, reserva: { created_by: @reserva.created_by, rsrv_codigo: @reserva.rsrv_codigo, rsrv_contactoId: @reserva.rsrv_contactoId, rsrv_estado: @reserva.rsrv_estado, rsrv_fechaVencimiento: @reserva.rsrv_fechaVencimiento, rsrv_productoId: @reserva.rsrv_productoId, rsrv_solicitanteId: @reserva.rsrv_solicitanteId, rsrv_tipoContacto: @reserva.rsrv_tipoContacto, rsrv_tipoProducto: @reserva.rsrv_tipoProducto, rsrv_tipoSolicitante: @reserva.rsrv_tipoSolicitante, updated_by: @reserva.updated_by }
    assert_redirected_to reserva_path(assigns(:reserva))
  end

  test "should destroy reserva" do
    assert_difference('Reserva.count', -1) do
      delete :destroy, id: @reserva
    end

    assert_redirected_to reservas_path
  end
end
