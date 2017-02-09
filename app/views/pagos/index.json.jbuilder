json.array!(@pagos) do |pago|
  json.extract! pago, :id, :pago_tipoProducto, :pago_productoId, :pago_valor, :pago_forma, :pago_ctaBancDestino, :pago_fecha, :pago_entidad, :dtpag_sucursalId, :pago_transaccion, :pago_estado, :pago_estadoRegistro, :created_by, :updated_by
  json.url pago_url(pago, format: :json)
end
