require 'test_helper'

class ControlsControllerTest < ActionController::TestCase
  setup do
    @control = controls(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:controls)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create control" do
    assert_difference('Control.count') do
      post :create, control: { accion_id: @control.accion_id, ctrl_created_by: @control.ctrl_created_by, ctrl_descripcion: @control.ctrl_descripcion, ctrl_estadoRegistro: @control.ctrl_estadoRegistro, ctrl_html_id: @control.ctrl_html_id, ctrl_tipo: @control.ctrl_tipo, ctrl_updated_by: @control.ctrl_updated_by, modelo_id: @control.modelo_id }
    end

    assert_redirected_to control_path(assigns(:control))
  end

  test "should show control" do
    get :show, id: @control
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @control
    assert_response :success
  end

  test "should update control" do
    patch :update, id: @control, control: { accion_id: @control.accion_id, ctrl_created_by: @control.ctrl_created_by, ctrl_descripcion: @control.ctrl_descripcion, ctrl_estadoRegistro: @control.ctrl_estadoRegistro, ctrl_html_id: @control.ctrl_html_id, ctrl_tipo: @control.ctrl_tipo, ctrl_updated_by: @control.ctrl_updated_by, modelo_id: @control.modelo_id }
    assert_redirected_to control_path(assigns(:control))
  end

  test "should destroy control" do
    assert_difference('Control.count', -1) do
      delete :destroy, id: @control
    end

    assert_redirected_to controls_path
  end
end
