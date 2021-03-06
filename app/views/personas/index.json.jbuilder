json.array!(@personas) do |persona|
  json.extract! persona, :id, :pers_documentoIdentidad, :pers_nombreCompleto, :pers_alias, :pers_sexo, :pers_fechaNacimiento, :pers_estadoCivil, :pers_direccionDomicilio, :pers_ciudadDomicilio, :pers_telefonoPersonal1, :pers_telefonoPersonal2, :pers_correoElectrPersonal, :pers_correoElectrLaboral, :pers_perfilLaboral, :sucursalEmpresaId, :empresaCargo, :pers_telefonoLaboral1, :pers_telefonoLaboral2, :pers_estadoRegistro
  json.url persona_url(persona, format: :json)
end
