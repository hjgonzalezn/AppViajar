json.array!(@tipo_actividad_turisticas) do |tipo_actividad_turistica|
  json.extract! tipo_actividad_turistica, :id, :tiAcT_nombre, :tiAcT_descripcion, :tiAcT_foto, :tiAcT_icono
  json.url tipo_actividad_turistica_url(tipo_actividad_turistica, format: :json)
end
