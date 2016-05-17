require 'test_helper'

class PersonasControllerTest < ActionController::TestCase
  setup do
    @persona = personas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:personas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create persona" do
    assert_difference('Persona.count') do
      post :create, persona: { empresaCargo: @persona.empresaCargo, pers_alias: @persona.pers_alias, pers_ciudadDomicilio: @persona.pers_ciudadDomicilio, pers_correoElectrLaboral: @persona.pers_correoElectrLaboral, pers_correoElectrPersonal: @persona.pers_correoElectrPersonal, pers_direccionDomicilio: @persona.pers_direccionDomicilio, pers_documentoIdentidad: @persona.pers_documentoIdentidad, pers_estadoCivil: @persona.pers_estadoCivil, pers_estadoRegistro: @persona.pers_estadoRegistro, pers_fechaNacimiento: @persona.pers_fechaNacimiento, pers_nombreCompleto: @persona.pers_nombreCompleto, pers_perfilLaboral: @persona.pers_perfilLaboral, pers_sexo: @persona.pers_sexo, pers_telefonoLaboral1: @persona.pers_telefonoLaboral1, pers_telefonoLaboral2: @persona.pers_telefonoLaboral2, pers_telefonoPersonal1: @persona.pers_telefonoPersonal1, pers_telefonoPersonal2: @persona.pers_telefonoPersonal2, sucursalEmpresaId: @persona.sucursalEmpresaId }
    end

    assert_redirected_to persona_path(assigns(:persona))
  end

  test "should show persona" do
    get :show, id: @persona
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @persona
    assert_response :success
  end

  test "should update persona" do
    patch :update, id: @persona, persona: { empresaCargo: @persona.empresaCargo, pers_alias: @persona.pers_alias, pers_ciudadDomicilio: @persona.pers_ciudadDomicilio, pers_correoElectrLaboral: @persona.pers_correoElectrLaboral, pers_correoElectrPersonal: @persona.pers_correoElectrPersonal, pers_direccionDomicilio: @persona.pers_direccionDomicilio, pers_documentoIdentidad: @persona.pers_documentoIdentidad, pers_estadoCivil: @persona.pers_estadoCivil, pers_estadoRegistro: @persona.pers_estadoRegistro, pers_fechaNacimiento: @persona.pers_fechaNacimiento, pers_nombreCompleto: @persona.pers_nombreCompleto, pers_perfilLaboral: @persona.pers_perfilLaboral, pers_sexo: @persona.pers_sexo, pers_telefonoLaboral1: @persona.pers_telefonoLaboral1, pers_telefonoLaboral2: @persona.pers_telefonoLaboral2, pers_telefonoPersonal1: @persona.pers_telefonoPersonal1, pers_telefonoPersonal2: @persona.pers_telefonoPersonal2, sucursalEmpresaId: @persona.sucursalEmpresaId }
    assert_redirected_to persona_path(assigns(:persona))
  end

  test "should destroy persona" do
    assert_difference('Persona.count', -1) do
      delete :destroy, id: @persona
    end

    assert_redirected_to personas_path
  end
end
