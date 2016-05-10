json.array!(@aeropuertos) do |aeropuerto|
  json.extract! aeropuerto, :id, :aeropt_nombre, :aeropt_codigoIATA, :aeropt_ciudadCdg, :aeropt_estadoRegistro
  json.url aeropuerto_url(aeropuerto, format: :json)
end
