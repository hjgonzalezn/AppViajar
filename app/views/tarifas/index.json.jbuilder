json.array!(@tarifas) do |tarifa|
  json.extract! tarifa, :id, :trf_concepto, :tfr_conceptoCodigo, :trf_conceptoAplicacion, :trf_detalleAplicacion, :trf_naturaleza, :trf_tipoProducto, :trf_producto, :trf_promo, :trf_econo, :trf_base, :trf_flexi, :trf_unidadCobro, :trf_fechaInicio, :trf_fechaFin, :trf_estadoRegistro
  json.url tarifa_url(tarifa, format: :json)
end
