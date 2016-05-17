json.array!(@vehiculos) do |vehiculo|
  json.extract! vehiculo, :id, :vehi_tipo, :vehi_modeloCodigo, :vehi_medioCodigo, :vehi_nombre, :vehi_matricula, :vehi_propietarioId, :vehi_tipoPropietario, :vehi_sucursalEmpresaPropId, :vehi_capacPesoMaximo, :vehi_capacPesoPasajeros, :vehi_capacCargaBodega, :vehi_capacPasajeros, :vehi_estadoRegistro
  json.url vehiculo_url(vehiculo, format: :json)
end
