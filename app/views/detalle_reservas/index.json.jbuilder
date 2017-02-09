json.array!(@detalle_reservas) do |detalle_reserva|
  json.extract! detalle_reserva, :id, :reserva_id, :detRsrv_estado, :detRsrv_tipoCliente, :detRsrv_clienteId, :detRsrv_tarifaCodigo, :detRsrv_valor, :created_by, :updated_by
  json.url detalle_reserva_url(detalle_reserva, format: :json)
end
