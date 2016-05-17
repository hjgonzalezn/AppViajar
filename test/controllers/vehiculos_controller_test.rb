require 'test_helper'

class VehiculosControllerTest < ActionController::TestCase
  setup do
    @vehiculo = vehiculos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:vehiculos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create vehiculo" do
    assert_difference('Vehiculo.count') do
      post :create, vehiculo: { vehi_capacCargaBodega: @vehiculo.vehi_capacCargaBodega, vehi_capacPasajeros: @vehiculo.vehi_capacPasajeros, vehi_capacPesoMaximo: @vehiculo.vehi_capacPesoMaximo, vehi_capacPesoPasajeros: @vehiculo.vehi_capacPesoPasajeros, vehi_estadoRegistro: @vehiculo.vehi_estadoRegistro, vehi_matricula: @vehiculo.vehi_matricula, vehi_medioCodigo: @vehiculo.vehi_medioCodigo, vehi_modeloCodigo: @vehiculo.vehi_modeloCodigo, vehi_nombre: @vehiculo.vehi_nombre, vehi_propietarioId: @vehiculo.vehi_propietarioId, vehi_sucursalEmpresaPropId: @vehiculo.vehi_sucursalEmpresaPropId, vehi_tipo: @vehiculo.vehi_tipo, vehi_tipoPropietario: @vehiculo.vehi_tipoPropietario }
    end

    assert_redirected_to vehiculo_path(assigns(:vehiculo))
  end

  test "should show vehiculo" do
    get :show, id: @vehiculo
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @vehiculo
    assert_response :success
  end

  test "should update vehiculo" do
    patch :update, id: @vehiculo, vehiculo: { vehi_capacCargaBodega: @vehiculo.vehi_capacCargaBodega, vehi_capacPasajeros: @vehiculo.vehi_capacPasajeros, vehi_capacPesoMaximo: @vehiculo.vehi_capacPesoMaximo, vehi_capacPesoPasajeros: @vehiculo.vehi_capacPesoPasajeros, vehi_estadoRegistro: @vehiculo.vehi_estadoRegistro, vehi_matricula: @vehiculo.vehi_matricula, vehi_medioCodigo: @vehiculo.vehi_medioCodigo, vehi_modeloCodigo: @vehiculo.vehi_modeloCodigo, vehi_nombre: @vehiculo.vehi_nombre, vehi_propietarioId: @vehiculo.vehi_propietarioId, vehi_sucursalEmpresaPropId: @vehiculo.vehi_sucursalEmpresaPropId, vehi_tipo: @vehiculo.vehi_tipo, vehi_tipoPropietario: @vehiculo.vehi_tipoPropietario }
    assert_redirected_to vehiculo_path(assigns(:vehiculo))
  end

  test "should destroy vehiculo" do
    assert_difference('Vehiculo.count', -1) do
      delete :destroy, id: @vehiculo
    end

    assert_redirected_to vehiculos_path
  end
end
