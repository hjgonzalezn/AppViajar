require 'test_helper'

class TipoActividadTuristicasControllerTest < ActionController::TestCase
  setup do
    @tipo_actividad_turistica = tipo_actividad_turisticas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tipo_actividad_turisticas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tipo_actividad_turistica" do
    assert_difference('TipoActividadTuristica.count') do
      post :create, tipo_actividad_turistica: { tiAcT_descripcion: @tipo_actividad_turistica.tiAcT_descripcion, tiAcT_foto: @tipo_actividad_turistica.tiAcT_foto, tiAcT_icono: @tipo_actividad_turistica.tiAcT_icono, tiAcT_nombre: @tipo_actividad_turistica.tiAcT_nombre }
    end

    assert_redirected_to tipo_actividad_turistica_path(assigns(:tipo_actividad_turistica))
  end

  test "should show tipo_actividad_turistica" do
    get :show, id: @tipo_actividad_turistica
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @tipo_actividad_turistica
    assert_response :success
  end

  test "should update tipo_actividad_turistica" do
    patch :update, id: @tipo_actividad_turistica, tipo_actividad_turistica: { tiAcT_descripcion: @tipo_actividad_turistica.tiAcT_descripcion, tiAcT_foto: @tipo_actividad_turistica.tiAcT_foto, tiAcT_icono: @tipo_actividad_turistica.tiAcT_icono, tiAcT_nombre: @tipo_actividad_turistica.tiAcT_nombre }
    assert_redirected_to tipo_actividad_turistica_path(assigns(:tipo_actividad_turistica))
  end

  test "should destroy tipo_actividad_turistica" do
    assert_difference('TipoActividadTuristica.count', -1) do
      delete :destroy, id: @tipo_actividad_turistica
    end

    assert_redirected_to tipo_actividad_turisticas_path
  end
end
