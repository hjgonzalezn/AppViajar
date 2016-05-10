json.array!(@unidad_territorials) do |unidad_territorial|
  json.extract! unidad_territorial, :id, :undter_nombre, :undter_estadoRegistro
  json.url unidad_territorial_url(unidad_territorial, format: :json)
end
