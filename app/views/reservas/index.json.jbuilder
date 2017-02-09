json.array!(@reservas) do |reserva|
  json.extract! reserva, :id, :rsrv_codigo, :rsrv_tipoProducto, :rsrv_productoId, :rsrv_tipoSolicitante, :rsrv_solicitanteId, :rsrv_tipoContacto, :rsrv_contactoId, :rsrv_estado, :rsrv_fechaVencimiento, :created_by, :updated_by
  json.url reserva_url(reserva, format: :json)
end
