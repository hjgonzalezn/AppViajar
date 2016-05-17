require 'test_helper'

class SucursalEmpresasControllerTest < ActionController::TestCase
  setup do
    @sucursal_empresa = sucursal_empresas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sucursal_empresas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sucursal_empresa" do
    assert_difference('SucursalEmpresa.count') do
      post :create, sucursal_empresa: { docIdentContacto2: @sucursal_empresa.docIdentContacto2, empr_documentoIdentidad: @sucursal_empresa.empr_documentoIdentidad, sucEmp_estadoRegistro: @sucursal_empresa.sucEmp_estadoRegistro, sucEmpr_TipoSucursal: @sucursal_empresa.sucEmpr_TipoSucursal, sucEmpr_ciudadDomicilio: @sucursal_empresa.sucEmpr_ciudadDomicilio, sucEmpr_correoElectronico: @sucursal_empresa.sucEmpr_correoElectronico, sucEmpr_direccion: @sucursal_empresa.sucEmpr_direccion, sucEmpr_docIdentContacto1: @sucursal_empresa.sucEmpr_docIdentContacto1, sucEmpr_horarioAtencion: @sucursal_empresa.sucEmpr_horarioAtencion, sucEmpr_telefono1: @sucursal_empresa.sucEmpr_telefono1, sucEmpr_telefono2: @sucursal_empresa.sucEmpr_telefono2 }
    end

    assert_redirected_to sucursal_empresa_path(assigns(:sucursal_empresa))
  end

  test "should show sucursal_empresa" do
    get :show, id: @sucursal_empresa
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @sucursal_empresa
    assert_response :success
  end

  test "should update sucursal_empresa" do
    patch :update, id: @sucursal_empresa, sucursal_empresa: { docIdentContacto2: @sucursal_empresa.docIdentContacto2, empr_documentoIdentidad: @sucursal_empresa.empr_documentoIdentidad, sucEmp_estadoRegistro: @sucursal_empresa.sucEmp_estadoRegistro, sucEmpr_TipoSucursal: @sucursal_empresa.sucEmpr_TipoSucursal, sucEmpr_ciudadDomicilio: @sucursal_empresa.sucEmpr_ciudadDomicilio, sucEmpr_correoElectronico: @sucursal_empresa.sucEmpr_correoElectronico, sucEmpr_direccion: @sucursal_empresa.sucEmpr_direccion, sucEmpr_docIdentContacto1: @sucursal_empresa.sucEmpr_docIdentContacto1, sucEmpr_horarioAtencion: @sucursal_empresa.sucEmpr_horarioAtencion, sucEmpr_telefono1: @sucursal_empresa.sucEmpr_telefono1, sucEmpr_telefono2: @sucursal_empresa.sucEmpr_telefono2 }
    assert_redirected_to sucursal_empresa_path(assigns(:sucursal_empresa))
  end

  test "should destroy sucursal_empresa" do
    assert_difference('SucursalEmpresa.count', -1) do
      delete :destroy, id: @sucursal_empresa
    end

    assert_redirected_to sucursal_empresas_path
  end
end
