json.array!(@hotels) do |hotel|
  json.extract! hotel, :id, :empresa_id, :hotel_datosGenerales, :hotel_presentacion, :hotel_servicios, :hotel_atractivos, :hotel_estadoRegistro
  json.url hotel_url(hotel, format: :json)
end
