require 'test_helper'

class PaqueteTuristicosControllerTest < ActionController::TestCase
  setup do
    @paquete_turistico = paquete_turisticos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:paquete_turisticos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create paquete_turistico" do
    assert_difference('PaqueteTuristico.count') do
      post :create, paquete_turistico: { pqTur_descripcion: @paquete_turistico.pqTur_descripcion, pqTur_estadoRegistro: @paquete_turistico.pqTur_estadoRegistro, pqTur_fechaPromocionFin: @paquete_turistico.pqTur_fechaPromocionFin, pqTur_fechaPromocionIni: @paquete_turistico.pqTur_fechaPromocionIni, pqTur_fechaVigenciaFin: @paquete_turistico.pqTur_fechaVigenciaFin, pqTur_fechaVigenciaIni: @paquete_turistico.pqTur_fechaVigenciaIni, pqTur_incluye: @paquete_turistico.pqTur_incluye, pqTur_noIncluye: @paquete_turistico.pqTur_noIncluye, pqTur_nombre: @paquete_turistico.pqTur_nombre, pqTur_opcionales: @paquete_turistico.pqTur_opcionales, pqTur_recomendaciones: @paquete_turistico.pqTur_recomendaciones }
    end

    assert_redirected_to paquete_turistico_path(assigns(:paquete_turistico))
  end

  test "should show paquete_turistico" do
    get :show, id: @paquete_turistico
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @paquete_turistico
    assert_response :success
  end

  test "should update paquete_turistico" do
    patch :update, id: @paquete_turistico, paquete_turistico: { pqTur_descripcion: @paquete_turistico.pqTur_descripcion, pqTur_estadoRegistro: @paquete_turistico.pqTur_estadoRegistro, pqTur_fechaPromocionFin: @paquete_turistico.pqTur_fechaPromocionFin, pqTur_fechaPromocionIni: @paquete_turistico.pqTur_fechaPromocionIni, pqTur_fechaVigenciaFin: @paquete_turistico.pqTur_fechaVigenciaFin, pqTur_fechaVigenciaIni: @paquete_turistico.pqTur_fechaVigenciaIni, pqTur_incluye: @paquete_turistico.pqTur_incluye, pqTur_noIncluye: @paquete_turistico.pqTur_noIncluye, pqTur_nombre: @paquete_turistico.pqTur_nombre, pqTur_opcionales: @paquete_turistico.pqTur_opcionales, pqTur_recomendaciones: @paquete_turistico.pqTur_recomendaciones }
    assert_redirected_to paquete_turistico_path(assigns(:paquete_turistico))
  end

  test "should destroy paquete_turistico" do
    assert_difference('PaqueteTuristico.count', -1) do
      delete :destroy, id: @paquete_turistico
    end

    assert_redirected_to paquete_turisticos_path
  end
end
