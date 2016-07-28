json.array!(@viajes) do |viaje|
  json.extract! viaje, :id, :viaje_ruta, :viaje_fecha, :viaje_horaSalida, :viaje_estado, :vehiculo_id, :viaje_estadoRegistro
  json.url viaje_url(viaje, format: :json)
end
