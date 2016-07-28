json.array!(@ruta) do |rutum|
  json.extract! rutum, :id, :ruta_medio, :ruta_descripcion, :ruta_frecuencia, :ruta_vehiculo, :ruta_estadoRegistro
  json.url rutum_url(rutum, format: :json)
end
