json.array!(@entidad_territorials) do |entidad_territorial|
  json.extract! entidad_territorial, :id, :enter_nombreOficial, :enter_presentacion, :enter_padreId, :enter_nivel, :region_id, :division_pais_id, :enter_estadoRegistro
  json.url entidad_territorial_url(entidad_territorial, format: :json)
end
