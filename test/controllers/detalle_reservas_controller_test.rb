require 'test_helper'

class DetalleReservasControllerTest < ActionController::TestCase
  setup do
    @detalle_reserva = detalle_reservas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:detalle_reservas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create detalle_reserva" do
    assert_difference('DetalleReserva.count') do
      post :create, detalle_reserva: { created_by: @detalle_reserva.created_by, detRsrv_clienteId: @detalle_reserva.detRsrv_clienteId, detRsrv_estado: @detalle_reserva.detRsrv_estado, detRsrv_tarifaCodigo: @detalle_reserva.detRsrv_tarifaCodigo, detRsrv_tipoCliente: @detalle_reserva.detRsrv_tipoCliente, detRsrv_valor: @detalle_reserva.detRsrv_valor, reserva_id: @detalle_reserva.reserva_id, updated_by: @detalle_reserva.updated_by }
    end

    assert_redirected_to detalle_reserva_path(assigns(:detalle_reserva))
  end

  test "should show detalle_reserva" do
    get :show, id: @detalle_reserva
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @detalle_reserva
    assert_response :success
  end

  test "should update detalle_reserva" do
    patch :update, id: @detalle_reserva, detalle_reserva: { created_by: @detalle_reserva.created_by, detRsrv_clienteId: @detalle_reserva.detRsrv_clienteId, detRsrv_estado: @detalle_reserva.detRsrv_estado, detRsrv_tarifaCodigo: @detalle_reserva.detRsrv_tarifaCodigo, detRsrv_tipoCliente: @detalle_reserva.detRsrv_tipoCliente, detRsrv_valor: @detalle_reserva.detRsrv_valor, reserva_id: @detalle_reserva.reserva_id, updated_by: @detalle_reserva.updated_by }
    assert_redirected_to detalle_reserva_path(assigns(:detalle_reserva))
  end

  test "should destroy detalle_reserva" do
    assert_difference('DetalleReserva.count', -1) do
      delete :destroy, id: @detalle_reserva
    end

    assert_redirected_to detalle_reservas_path
  end
end
