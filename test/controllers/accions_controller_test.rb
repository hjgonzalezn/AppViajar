require 'test_helper'

class AccionsControllerTest < ActionController::TestCase
  setup do
    @accion = accions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:accions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create accion" do
    assert_difference('Accion.count') do
      post :create, accion: { acc_codigo: @accion.acc_codigo, acc_estadoRegistro: @accion.acc_estadoRegistro, acc_nombre: @accion.acc_nombre }
    end

    assert_redirected_to accion_path(assigns(:accion))
  end

  test "should show accion" do
    get :show, id: @accion
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @accion
    assert_response :success
  end

  test "should update accion" do
    patch :update, id: @accion, accion: { acc_codigo: @accion.acc_codigo, acc_estadoRegistro: @accion.acc_estadoRegistro, acc_nombre: @accion.acc_nombre }
    assert_redirected_to accion_path(assigns(:accion))
  end

  test "should destroy accion" do
    assert_difference('Accion.count', -1) do
      delete :destroy, id: @accion
    end

    assert_redirected_to accions_path
  end
end
