require 'test_helper'

class CausalsControllerTest < ActionController::TestCase
  setup do
    @causal = causals(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:causals)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create causal" do
    assert_difference('Causal.count') do
      post :create, causal: { causal_descripcion: @causal.causal_descripcion, causal_estadoRegistro: @causal.causal_estadoRegistro, causal_nivel: @causal.causal_nivel, causal_solucion: @causal.causal_solucion, causal_tipo: @causal.causal_tipo }
    end

    assert_redirected_to causal_path(assigns(:causal))
  end

  test "should show causal" do
    get :show, id: @causal
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @causal
    assert_response :success
  end

  test "should update causal" do
    patch :update, id: @causal, causal: { causal_descripcion: @causal.causal_descripcion, causal_estadoRegistro: @causal.causal_estadoRegistro, causal_nivel: @causal.causal_nivel, causal_solucion: @causal.causal_solucion, causal_tipo: @causal.causal_tipo }
    assert_redirected_to causal_path(assigns(:causal))
  end

  test "should destroy causal" do
    assert_difference('Causal.count', -1) do
      delete :destroy, id: @causal
    end

    assert_redirected_to causals_path
  end
end
