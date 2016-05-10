require 'test_helper'

class DivisionPaisControllerTest < ActionController::TestCase
  setup do
    @division_pai = division_pais(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:division_pais)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create division_pai" do
    assert_difference('DivisionPai.count') do
      post :create, division_pai: { divpais_estadoRegistro: @division_pai.divpais_estadoRegistro, divpais_nivel: @division_pai.divpais_nivel, entidad_territorial_id: @division_pai.entidad_territorial_id, unidad_territorial_id: @division_pai.unidad_territorial_id }
    end

    assert_redirected_to division_pai_path(assigns(:division_pai))
  end

  test "should show division_pai" do
    get :show, id: @division_pai
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @division_pai
    assert_response :success
  end

  test "should update division_pai" do
    patch :update, id: @division_pai, division_pai: { divpais_estadoRegistro: @division_pai.divpais_estadoRegistro, divpais_nivel: @division_pai.divpais_nivel, entidad_territorial_id: @division_pai.entidad_territorial_id, unidad_territorial_id: @division_pai.unidad_territorial_id }
    assert_redirected_to division_pai_path(assigns(:division_pai))
  end

  test "should destroy division_pai" do
    assert_difference('DivisionPai.count', -1) do
      delete :destroy, id: @division_pai
    end

    assert_redirected_to division_pais_path
  end
end
