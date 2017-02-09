module ReservasHelper
  
  def tarifas_viaje(viajeId)
    instSQL_Select = "viajes.viaje_tarifas, T.trf_promo, T.trf_econo, T.trf_base, T.trf_flexi, T.trf_deluxe"
    instSQL_Joins = "INNER JOIN ruta R ON viajes.viaje_ruta = R.id
                     INNER JOIN tarifas T ON trf_producto = R.id"
    instSQL_Where = "T.trf_conceptoCodigo = 'VLPAX' AND T.trf_conceptoAplicacion = 'RUTA' AND T.trf_fechaInicio < viajes.viaje_fecha AND (T.trf_fechaFin IS NULL OR T.trf_fechaFin > viajes.viaje_fecha) AND viajes.id = #{viajeId}"
    tarifas = Viaje.select(instSQL_Select).where(instSQL_Where).joins(instSQL_Joins).take
    return tarifas
  end
  
  def reserva_calcular_tarifa(codigoReserva)
    valorAPagar = 0
    parametro = Catalogo.where(ctlg_valorCdg: :BOME).take
    bonoDctoMenor = parametro.ctlg_observacion.to_f
    
    instSQL_Select = "reservas.rsrv_tipoProducto, reservas.rsrv_productoId, DR.detRsrv_tipoCliente, DR.detRsrv_clienteId, P.pers_fechaNacimiento, P.pers_nombres"
    instSQL_Where = "reservas.rsrv_estadoRegistro = 'A' AND DR.detRsrv_estadoRegistro = 'A' AND reservas.rsrv_codigo = '#{codigoReserva}'"
    instSQL_Joins = "INNER JOIN detalle_reservas DR ON Reservas.id = DR.reserva_id
                     INNER JOIN personas P ON DR.detRsrv_clienteId = P.pers_documentoIdentidad"
    reservas = Reserva.select(instSQL_Select).where(instSQL_Where).joins(instSQL_Joins)
    
    rsrv = reservas.first
    
    case rsrv.rsrv_tipoProducto
      when "VUELO" then
        viaje = tarifas_viaje(rsrv.rsrv_productoId)
 
        if viaje.viaje_tarifas.blank?
          valorAPagar = viaje.trf_base * reservas.length
        else
          tarifasViaje = viaje.viaje_tarifas.split("|")
          index = 0
          reservas.each do |h|
            grupoEdad = grupo_edad_persona(h.pers_fechaNacimiento) 
            unless grupoEdad == "INFANTE" then
              for i in index..tarifasViaje.length - 1
                tarifasViaje[index] = tarifasViaje[index].to_i
                if tarifasViaje[index].to_i == 0 then
                  index = index + 1
                end 
              end  

              case index
                when 0 then
                  valorAPagar = valorAPagar + viaje.trf_promo
                when 1 then
                  valorAPagar = valorAPagar + viaje.trf_econo
                when 2 then
                  valorAPagar = valorAPagar + viaje.trf_base
                when 3 then
                  valorAPagar = valorAPagar + viaje.trf_flexi
                when 4 then
                  valorAPagar = valorAPagar + viaje.trf_deluxe
              end
              
              if index > 0 && index <= 4 && grupoEdad == "MENOR" then
                valorAPagar = valorAPagar - bonoDctoMenor
              end    
              
              #puts "############>>>>>>"
              #puts h.pers_nombres + " " + valorAPagar.to_s + " idx " + index.to_s + ", tarifas " + tarifasViaje[index].to_s
              tarifasViaje[index] = tarifasViaje[index] - 1
            end #infante
          end
       end
    end

    return valorAPagar  
  end
  
  def reservas_buscar documentoIdentidad=nil, apellidos=nil, nombres=nil, codigoReserva=nil, fechaViajeIni=nil, fechaViajeFin=nil, vendedor=nil
    
    instSQL_Select = "reservas.id, reservas.rsrv_codigo, reservas.rsrv_tipoProducto, reservas.rsrv_fechaIda, reservas.rsrv_fechaRegreso, reservas.rsrv_estadoReserva, reservas.rsrv_trayectoViaje, 'NAISATOURS' vendedor, DR.detRsrv_tipoCliente, DR.detRsrv_clienteId, P.pers_nombres, P.pers_apellidos, P.pers_fechaNacimiento"
    instSQL_Where = "reservas.rsrv_estadoRegistro = 'A' AND DR.detRsrv_estadoRegistro = 'A' "
    instSQL_Joins = "INNER JOIN detalle_reservas DR ON Reservas.id = DR.reserva_id
                    INNER JOIN personas P ON DR.detRsrv_clienteId = P.pers_documentoIdentidad"
                    
                    
    unless documentoIdentidad.blank?
      instSQL_Where = instSQL_Where + "AND P.pers_documentoIdentidad = '" + documentoIdentidad + "'"
    end
    
    unless nombres.blank?
      instSQL_Where = instSQL_Where + "AND P.pers_nombres LIKE '%" + nombres + "%'"
    end
    
    unless apellidos.blank?
      instSQL_Where = instSQL_Where + "AND P.pers_apellidos LIKE '%" + apellidos + "%'"
    end
    
    unless codigoReserva.blank?
      instSQL_Where = instSQL_Where + "AND reservas.rsrv_codigo = '" + codigoReserva + "'"
    end
    
    unless fechaViajeIni.blank? && fechaViajeFin.blank? then
      instSQL_Where = instSQL_Where + "AND (reservas.rsrv_fechaIda BETWEEN '" + fechaViajeIni + "' AND '" + fechaViajeFin + "' OR reservas.rsrv_fechaRegreso BETWEEN '" + fechaViajeIni + "' AND '" + fechaViajeFin + "')"
    end
                     
    reservas = Reserva.select(instSQL_Select).where(instSQL_Where).joins(instSQL_Joins).order("P.pers_nombres ASC")
    return reservas
    
  end
end
