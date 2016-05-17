json.array!(@sucursal_empresas) do |sucursal_empresa|
  json.extract! sucursal_empresa, :id, :empr_documentoIdentidad, :sucEmpr_ciudadDomicilio, :sucEmpr_direccion, :sucEmpr_telefono1, :sucEmpr_telefono2, :sucEmpr_correoElectronico, :sucEmpr_docIdentContacto1, :docIdentContacto2, :sucEmpr_TipoSucursal, :sucEmpr_horarioAtencion, :sucEmp_estadoRegistro
  json.url sucursal_empresa_url(sucursal_empresa, format: :json)
end
