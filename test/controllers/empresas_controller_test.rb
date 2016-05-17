require 'test_helper'

class EmpresasControllerTest < ActionController::TestCase
  setup do
    @empresa = empresas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:empresas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create empresa" do
    assert_difference('Empresa.count') do
      post :create, empresa: { empr_docIdentReprLegal: @empresa.empr_docIdentReprLegal, empr_documentoIdentidad: @empresa.empr_documentoIdentidad, empr_estadoRegistro: @empresa.empr_estadoRegistro, empr_otrosDatos: @empresa.empr_otrosDatos, empr_razonSocial: @empresa.empr_razonSocial, empr_sectorEconomico: @empresa.empr_sectorEconomico, empr_sitioWeb: @empresa.empr_sitioWeb, empr_tipoEmpresa: @empresa.empr_tipoEmpresa }
    end

    assert_redirected_to empresa_path(assigns(:empresa))
  end

  test "should show empresa" do
    get :show, id: @empresa
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @empresa
    assert_response :success
  end

  test "should update empresa" do
    patch :update, id: @empresa, empresa: { empr_docIdentReprLegal: @empresa.empr_docIdentReprLegal, empr_documentoIdentidad: @empresa.empr_documentoIdentidad, empr_estadoRegistro: @empresa.empr_estadoRegistro, empr_otrosDatos: @empresa.empr_otrosDatos, empr_razonSocial: @empresa.empr_razonSocial, empr_sectorEconomico: @empresa.empr_sectorEconomico, empr_sitioWeb: @empresa.empr_sitioWeb, empr_tipoEmpresa: @empresa.empr_tipoEmpresa }
    assert_redirected_to empresa_path(assigns(:empresa))
  end

  test "should destroy empresa" do
    assert_difference('Empresa.count', -1) do
      delete :destroy, id: @empresa
    end

    assert_redirected_to empresas_path
  end
end
