json.array!(@accions) do |accion|
  json.extract! accion, :id, :acc_codigo, :acc_nombre, :acc_estadoRegistro
  json.url accion_url(accion, format: :json)
end
