require 'test_helper'

class TarifasControllerTest < ActionController::TestCase
  setup do
    @tarifa = tarifas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tarifas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tarifa" do
    assert_difference('Tarifa.count') do
      post :create, tarifa: { tfr_conceptoCodigo: @tarifa.tfr_conceptoCodigo, trf_base: @tarifa.trf_base, trf_concepto: @tarifa.trf_concepto, trf_conceptoAplicacion: @tarifa.trf_conceptoAplicacion, trf_detalleAplicacion: @tarifa.trf_detalleAplicacion, trf_econo: @tarifa.trf_econo, trf_estadoRegistro: @tarifa.trf_estadoRegistro, trf_fechaFin: @tarifa.trf_fechaFin, trf_fechaInicio: @tarifa.trf_fechaInicio, trf_flexi: @tarifa.trf_flexi, trf_naturaleza: @tarifa.trf_naturaleza, trf_producto: @tarifa.trf_producto, trf_promo: @tarifa.trf_promo, trf_tipoProducto: @tarifa.trf_tipoProducto, trf_unidadCobro: @tarifa.trf_unidadCobro }
    end

    assert_redirected_to tarifa_path(assigns(:tarifa))
  end

  test "should show tarifa" do
    get :show, id: @tarifa
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @tarifa
    assert_response :success
  end

  test "should update tarifa" do
    patch :update, id: @tarifa, tarifa: { tfr_conceptoCodigo: @tarifa.tfr_conceptoCodigo, trf_base: @tarifa.trf_base, trf_concepto: @tarifa.trf_concepto, trf_conceptoAplicacion: @tarifa.trf_conceptoAplicacion, trf_detalleAplicacion: @tarifa.trf_detalleAplicacion, trf_econo: @tarifa.trf_econo, trf_estadoRegistro: @tarifa.trf_estadoRegistro, trf_fechaFin: @tarifa.trf_fechaFin, trf_fechaInicio: @tarifa.trf_fechaInicio, trf_flexi: @tarifa.trf_flexi, trf_naturaleza: @tarifa.trf_naturaleza, trf_producto: @tarifa.trf_producto, trf_promo: @tarifa.trf_promo, trf_tipoProducto: @tarifa.trf_tipoProducto, trf_unidadCobro: @tarifa.trf_unidadCobro }
    assert_redirected_to tarifa_path(assigns(:tarifa))
  end

  test "should destroy tarifa" do
    assert_difference('Tarifa.count', -1) do
      delete :destroy, id: @tarifa
    end

    assert_redirected_to tarifas_path
  end
end
