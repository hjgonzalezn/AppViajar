require 'test_helper'

class ActividadTuristicasControllerTest < ActionController::TestCase
  setup do
    @actividad_turistica = actividad_turisticas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:actividad_turisticas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create actividad_turistica" do
    assert_difference('ActividadTuristica.count') do
      post :create, actividad_turistica: { actur_descripcion: @actividad_turistica.actur_descripcion, actur_estadoRegistro: @actividad_turistica.actur_estadoRegistro, tipo_actividad_turistica_id: @actividad_turistica.tipo_actividad_turistica_id }
    end

    assert_redirected_to actividad_turistica_path(assigns(:actividad_turistica))
  end

  test "should show actividad_turistica" do
    get :show, id: @actividad_turistica
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @actividad_turistica
    assert_response :success
  end

  test "should update actividad_turistica" do
    patch :update, id: @actividad_turistica, actividad_turistica: { actur_descripcion: @actividad_turistica.actur_descripcion, actur_estadoRegistro: @actividad_turistica.actur_estadoRegistro, tipo_actividad_turistica_id: @actividad_turistica.tipo_actividad_turistica_id }
    assert_redirected_to actividad_turistica_path(assigns(:actividad_turistica))
  end

  test "should destroy actividad_turistica" do
    assert_difference('ActividadTuristica.count', -1) do
      delete :destroy, id: @actividad_turistica
    end

    assert_redirected_to actividad_turisticas_path
  end
end
