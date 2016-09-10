json.array!(@modelos) do |modelo|
  json.extract! modelo, :id, :mdl_codigo, :mdl_nombre, :mdl_estadoRegistro
  json.url modelo_url(modelo, format: :json)
end
