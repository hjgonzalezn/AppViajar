module ActividadTuristicasHelper
  def set_actividades_plan(paquete_turistico)
    instSQL_joins = "AS AT LEFT JOIN actividad_turistica_plans ATP ON (ATP.actividad_turistica_id = AT.id AND ATP.paquete_turistico_id = " + paquete_turistico.to_s + ") INNER JOIN tipo_actividad_turisticas TAT ON AT.tipo_actividad_turistica_id = TAT.id INNER JOIN Tarifas T ON (AT.id = T.trf_producto) "
    actividades_plan = ActividadTuristica.select("AT.id, AT.actur_descripcion, TAT.tiAcT_nombre, ATP.id AS ATP_id, ATP.atp_clasificacion").joins(instSQL_joins).where("AT.acTur_estadoRegistro = 'A' AND T.trf_estadoRegistro = 'A' AND T.trf_tipoProducto = 'ACTIVIDAD_TURISTICAS'")
  end
  
  def set_actividades_reserva(reserva)
    instSQL_joins = "AS AT INNER JOIN actividad_turistica_reservas ATR ON AT.id = ATR.actividad_turistica_id AND ATR.reserva_id = " + reserva.to_s
    instSQL_conditions = "AT.actur_estadoRegistro = 'A' AND ATR.atr_estadoRegistro = 'A'" 
    ActividadTuristica.select("AT.actur_descripcion").joins(instSQL_joins).where(instSQL_conditions)
  end
  
  
end
