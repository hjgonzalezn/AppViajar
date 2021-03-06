require 'test_helper'

class FotosControllerTest < ActionController::TestCase
  setup do
    @foto = fotos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:fotos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create foto" do
    assert_difference('Foto.count') do
      post :create, foto: { foto_descripcion: @foto.foto_descripcion, foto_entidadCodigo: @foto.foto_entidadCodigo, foto_entidad_id: @foto.foto_entidad_id, foto_estadoRegistro: @foto.foto_estadoRegistro, foto_nombreArchivo: @foto.foto_nombreArchivo, foto_portada: @foto.foto_portada, foto_ruta: @foto.foto_ruta, foto_titulo: @foto.foto_titulo }
    end

    assert_redirected_to foto_path(assigns(:foto))
  end

  test "should show foto" do
    get :show, id: @foto
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @foto
    assert_response :success
  end

  test "should update foto" do
    patch :update, id: @foto, foto: { foto_descripcion: @foto.foto_descripcion, foto_entidadCodigo: @foto.foto_entidadCodigo, foto_entidad_id: @foto.foto_entidad_id, foto_estadoRegistro: @foto.foto_estadoRegistro, foto_nombreArchivo: @foto.foto_nombreArchivo, foto_portada: @foto.foto_portada, foto_ruta: @foto.foto_ruta, foto_titulo: @foto.foto_titulo }
    assert_redirected_to foto_path(assigns(:foto))
  end

  test "should destroy foto" do
    assert_difference('Foto.count', -1) do
      delete :destroy, id: @foto
    end

    assert_redirected_to fotos_path
  end
end
