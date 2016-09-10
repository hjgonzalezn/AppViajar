json.array!(@controls) do |control|
  json.extract! control, :id, :ctrl_descripcion, :ctrl_html_id, :ctrl_tipo, :modelo_id, :accion_id, :ctrl_created_by, :ctrl_updated_by, :ctrl_estadoRegistro
  json.url control_url(control, format: :json)
end
