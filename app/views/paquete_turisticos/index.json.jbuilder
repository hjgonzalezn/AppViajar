json.array!(@paquete_turisticos) do |paquete_turistico|
  json.extract! paquete_turistico, :id, :pqTur_nombre, :pqTur_descripcion, :pqTur_incluye, :pqTur_noIncluye, :pqTur_opcionales, :pqTur_recomendaciones, :pqTur_fechaVigenciaIni, :pqTur_fechaVigenciaFin, :pqTur_fechaPromocionIni, :pqTur_fechaPromocionFin, :pqTur_estadoRegistro
  json.url paquete_turistico_url(paquete_turistico, format: :json)
end
