require 'test_helper'

class PagosControllerTest < ActionController::TestCase
  setup do
    @pago = pagos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pagos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pago" do
    assert_difference('Pago.count') do
      post :create, pago: { created_by: @pago.created_by, dtpag_sucursalId: @pago.dtpag_sucursalId, pago_ctaBancDestino: @pago.pago_ctaBancDestino, pago_entidad: @pago.pago_entidad, pago_estado: @pago.pago_estado, pago_estadoRegistro: @pago.pago_estadoRegistro, pago_fecha: @pago.pago_fecha, pago_forma: @pago.pago_forma, pago_productoId: @pago.pago_productoId, pago_tipoProducto: @pago.pago_tipoProducto, pago_transaccion: @pago.pago_transaccion, pago_valor: @pago.pago_valor, updated_by: @pago.updated_by }
    end

    assert_redirected_to pago_path(assigns(:pago))
  end

  test "should show pago" do
    get :show, id: @pago
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @pago
    assert_response :success
  end

  test "should update pago" do
    patch :update, id: @pago, pago: { created_by: @pago.created_by, dtpag_sucursalId: @pago.dtpag_sucursalId, pago_ctaBancDestino: @pago.pago_ctaBancDestino, pago_entidad: @pago.pago_entidad, pago_estado: @pago.pago_estado, pago_estadoRegistro: @pago.pago_estadoRegistro, pago_fecha: @pago.pago_fecha, pago_forma: @pago.pago_forma, pago_productoId: @pago.pago_productoId, pago_tipoProducto: @pago.pago_tipoProducto, pago_transaccion: @pago.pago_transaccion, pago_valor: @pago.pago_valor, updated_by: @pago.updated_by }
    assert_redirected_to pago_path(assigns(:pago))
  end

  test "should destroy pago" do
    assert_difference('Pago.count', -1) do
      delete :destroy, id: @pago
    end

    assert_redirected_to pagos_path
  end
end
