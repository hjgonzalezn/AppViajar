json.array!(@salidas) do |salida|
  json.extract! salida, :id, :paquete_turistico_id, :sld_fecha
  json.url salida_url(salida, format: :json)
end
