json.array!(@regions) do |region|
  json.extract! region, :id, :reg_nombre, :reg_presentacion, :reg_entidad_territorial_id, :reg_estadoRegistro
  json.url region_url(region, format: :json)
end
