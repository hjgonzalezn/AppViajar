json.array!(@fotos) do |foto|
  json.extract! foto, :id, :foto_nombreArchivo, :foto_ruta, :foto_titulo, :foto_descripcion, :foto_entidadCodigo, :foto_entidad_id, :foto_portada, :foto_estadoRegistro
  json.url foto_url(foto, format: :json)
end
