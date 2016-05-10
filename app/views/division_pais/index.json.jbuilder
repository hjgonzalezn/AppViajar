json.array!(@division_pais) do |division_pai|
  json.extract! division_pai, :id, :entidad_territorial_id, :unidad_territorial_id, :divpais_nivel, :divpais_estadoRegistro
  json.url division_pai_url(division_pai, format: :json)
end
