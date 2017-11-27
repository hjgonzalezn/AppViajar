module ReservasHelper
  
  def tarifas_viaje(viajeId, ruta)
    viaje = Viaje.find(viajeId)
    #{viaje.viaje_tarifas}' viaje_tarifas,
    instSQL_Select = "'#{viaje.viaje_tarifas}' viaje_tarifas, tarifas.trf_promo, tarifas.trf_econo, tarifas.trf_base, tarifas.trf_flexi, tarifas.trf_deluxe"
    instSQL_Joins = "INNER JOIN ruta ON (ruta.id = tarifas.trf_producto AND tarifas.trf_tipoProducto = 'RUTA')"
    instSQL_Where = "tarifas.trf_conceptoCodigo = 'VLPAX' AND tarifas.trf_conceptoAplicacion = 'RUTA' AND tarifas.trf_fechaInicio < '#{viaje.viaje_fecha}' AND (tarifas.trf_fechaFin IS NULL OR tarifas.trf_fechaFin > '#{viaje.viaje_fecha}') AND ruta.ruta_descripcion = '#{ruta}'"
    tarifas = Tarifa.select(instSQL_Select).where(instSQL_Where).joins(instSQL_Joins).take
    return tarifas
  end
  
  def tarifas_plan(paquete_turistico)
    instSQL_Select = "T.trf_detalleAplicacion, T.trf_base, T.trf_conceptoAplicacion"
    instSQL_Joins = "AS T INNER JOIN paquete_turisticos PT ON (PT.id = T.trf_producto AND T.trf_tipoProducto = 'PAQUETE_TURISTICOS')"
    instSQL_Where = "PT.id = " + paquete_turistico.to_s + " AND T.trf_conceptoCodigo = 'VPLAN' AND T.trf_unidadCobro = 'PERSONA' AND PT.pqTur_estadoRegistro = 'A' AND T.trf_estadoRegistro = 'A'"
    tarifas = Tarifa.select(instSQL_Select).joins(instSQL_Joins).where(instSQL_Where)
    return tarifas
  end
  
  
  #Calcula el valor de una reserva (reserva=>show de viajes) 
  def reserva_calcular_tarifa(codigoReserva)
    valorAPagar = 0
    parametro = Catalogo.where(ctlg_valorCdg: :BOME).take
    bonoDctoMenor = parametro.ctlg_observacion.to_f
    
    instSQL_Select = "reservas.rsrv_tipoProducto, reservas.rsrv_productoId, reservas.rsrv_valorTotal, reservas.rsrv_trayectoViaje, DR.detRsrv_tipoCliente, DR.detRsrv_clienteId, P.pers_fechaNacimiento, P.pers_nombres, (reservas.rsrv_fechaRegreso - reservas.rsrv_fechaIda + 1) dias"
    instSQL_Where = "reservas.rsrv_estadoRegistro = 'A' AND DR.detRsrv_estadoRegistro = 'A' AND reservas.rsrv_codigo = '#{codigoReserva}'"
    instSQL_Joins = "INNER JOIN detalle_reservas DR ON reservas.id = DR.reserva_id
                     INNER JOIN personas P ON DR.detRsrv_clienteId = P.pers_documentoIdentidad"
    reservas = Reserva.select(instSQL_Select).where(instSQL_Where).joins(instSQL_Joins)
    
    rsrv = reservas.first
    
    case rsrv.rsrv_tipoProducto
      when "VUELO" then
        viaje = tarifas_viaje(rsrv.rsrv_productoId, rsrv.rsrv_trayectoViaje)
        puts viaje.inspect
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

              tarifasViaje[index] = tarifasViaje[index] - 1
            end #infante
          end
        end
      when "PLAN" then
        valorAPagar = rsrv.rsrv_valorTotal
        
        # index = 0
#         
        # claveTarifa = rsrv.dias.to_s + "D/" + (rsrv.dias - 1).to_s + "N"
        # tarifas = tarifas_plan(rsrv.rsrv_productoId)
        # tarifaDefMenor = 0
        # tarifaDefAdulto = 0
#         
        # #Obteniendo las tarifas de adulto y menor de edad
        # tarifas.each do |h|
          # if h.trf_detalleAplicacion == claveTarifa then
            # case h.trf_conceptoAplicacion
              # when "ADULTO" then
                # tarifaDefAdulto = h.trf_base
              # when "MENOR" then
                # tarifaDefMenor = h.trf_base
            # end
          # end
        # end
#         
        # #Actividades opcionales
        # instSQL_select = "T.trf_base"
        # instSQL_where = "reserva_id = " + rsrv.rsrv_productoId.to_s + " AND atr_estadoRegistro = 'A' AND T.trf_estadoRegistro = 'A'"
        # instSQL_joins = "AS ATR INNER JOIN tarifas T ON (T.trf_conceptoCodigo = 'VACTUR' AND T.trf_tipoProducto = 'ACTIVIDAD_TURISTICAS' AND T.trf_producto = ATR.actividad_turistica_id)"
#         
        # valorOpcionalesAdulto = 0
        # valorOpcionalesMenor = 0
        # activOpcionales = ActividadTuristicaReserva.select(instSQL_select).where(instSQL_where).joins(instSQL_joins)
#         
        # #Calculando el valor total por individuo de las actividades opcionales
        # activOpcionales.each do |j|
          # valorOpcionalesAdulto += j.trf_base
          # valorOpcionalesMenor += j.trf_base  
        # end
#         
        # reservas.each do |h|
          # grupoEdad = grupo_edad_persona(h.pers_fechaNacimiento) 
          # puts grupoEdad
          # unless grupoEdad == "INFANTE" then
            # if grupoEdad == "ADULTO" then
              # valorAPagar += (tarifaDefAdulto + valorOpcionalesAdulto)
            # elsif grupoEdad == "MENOR" then
              # valorAPagar += (tarifaDefMenor + valorOpcionalesMenor) 
            # end
          # end
        # end
    end

    return valorAPagar  
  end
  
  def reservas_buscar documentoIdentidad=nil, apellidos=nil, nombres=nil, codigoReserva=nil, fechaViajeIni=nil, fechaViajeFin=nil, vendedor=nil
    
    instSQL_Select = "reservas.id, reservas.rsrv_codigo, reservas.rsrv_tipoProducto, reservas.rsrv_fechaIda, reservas.rsrv_fechaRegreso, reservas.rsrv_estadoReserva, reservas.rsrv_trayectoViaje, 'NAISATOURS' vendedor, DR.detRsrv_tipoCliente, DR.detRsrv_clienteId, P.pers_nombres, P.pers_apellidos, P.pers_fechaNacimiento"
    instSQL_Where = "reservas.rsrv_estadoRegistro = 'A' AND DR.detRsrv_estadoRegistro = 'A' "
    instSQL_Joins = "INNER JOIN detalle_reservas DR ON reservas.id = DR.reserva_id
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
  
  def reservas_salida_paquete_turistico(salidaId)
    instSQL_Select = "reservas.id, reservas.rsrv_codigo, reservas.rsrv_tipoProducto, reservas.rsrv_fechaIda, reservas.rsrv_fechaRegreso, reservas.rsrv_estadoReserva, reservas.rsrv_trayectoViaje, 'NAISATOURS' vendedor, DR.detRsrv_tipoCliente, DR.detRsrv_clienteId, P.pers_nombres, P.pers_apellidos, P.pers_fechaNacimiento"
    instSQL_Where = "reservas.rsrv_estadoRegistro = 'A' AND DR.detRsrv_estadoRegistro = 'A' AND PT.pqTur_estadoRegistro = 'A' AND reservas.rsrv_tipoProducto = 'PLAN'
                     AND S.sld_fecha = reservas.rsrv_fechaIda AND S.id = #{salidaId}"
    instSQL_Joins = "INNER JOIN detalle_reservas DR ON reservas.id = DR.reserva_id
                     INNER JOIN personas P ON DR.detRsrv_clienteId = P.pers_documentoIdentidad
                     INNER JOIN paquete_turisticos PT ON PT.id = reservas.rsrv_productoId
                     INNER JOIN salidas S ON PT.id = S.paquete_turistico_id"
                     
    reservas = Reserva.select(instSQL_Select).where(instSQL_Where).joins(instSQL_Joins).order("P.pers_nombres ASC")
    return reservas
  end
  
end
