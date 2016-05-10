require 'test_helper'

class CatalogosControllerTest < ActionController::TestCase
  setup do
    @catalogo = catalogos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:catalogos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create catalogo" do
    assert_difference('Catalogo.count') do
      post :create, catalogo: { ctlg_categoria: @catalogo.ctlg_categoria, ctlg_estadoRegistro: @catalogo.ctlg_estadoRegistro, ctlg_observacion: @catalogo.ctlg_observacion, ctlg_subcategoria: @catalogo.ctlg_subcategoria, ctlg_valorCdg: @catalogo.ctlg_valorCdg, ctlg_valorDesc: @catalogo.ctlg_valorDesc }
    end

    assert_redirected_to catalogo_path(assigns(:catalogo))
  end

  test "should show catalogo" do
    get :show, id: @catalogo
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @catalogo
    assert_response :success
  end

  test "should update catalogo" do
    patch :update, id: @catalogo, catalogo: { ctlg_categoria: @catalogo.ctlg_categoria, ctlg_estadoRegistro: @catalogo.ctlg_estadoRegistro, ctlg_observacion: @catalogo.ctlg_observacion, ctlg_subcategoria: @catalogo.ctlg_subcategoria, ctlg_valorCdg: @catalogo.ctlg_valorCdg, ctlg_valorDesc: @catalogo.ctlg_valorDesc }
    assert_redirected_to catalogo_path(assigns(:catalogo))
  end

  test "should destroy catalogo" do
    assert_difference('Catalogo.count', -1) do
      delete :destroy, id: @catalogo
    end

    assert_redirected_to catalogos_path
  end
end
