json.array!(@empresas) do |empresa|
  json.extract! empresa, :id, :empr_documentoIdentidad, :empr_razonSocial, :empr_tipoEmpresa, :empr_sectorEconomico, :empr_docIdentReprLegal, :empr_sitioWeb, :empr_otrosDatos, :empr_estadoRegistro
  json.url empresa_url(empresa, format: :json)
end
