json.array!(@actividad_turisticas) do |actividad_turistica|
  json.extract! actividad_turistica, :id, :actur_descripcion, :tipo_actividad_turistica_id, :actur_estadoRegistro
  json.url actividad_turistica_url(actividad_turistica, format: :json)
end
