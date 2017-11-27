module ViajesHelper
  
  #Determina la cantidad de sillas disponibles en un trayecto dado
  #Parametros:
  # => viaje_id: identificador del viaje
  # => viaje ruta: descripcion de la ruta del viaje
  # => origen: identificador ciudad origen del trayecto que se desea consultar
  # => destido: identificador ciudad destino del trayecto que se desea consultar
  def sillas_disponibles(viaje_id, viaje_ruta, origen, destino)
    sillasDisponibles = 0
    arrLugares = viaje_ruta.split("|")
    reservas = 0
    vehiCapacPasajeros = 0
    vehiculo = Vehiculo.select(:vehi_capacPasajeros).joins("INNER JOIN viajes V ON V.vehiculo_id = vehiculos.id").where("V.id = #{viaje_id}")

    unless vehiculo.nil?
      vehiCapacPasajeros = vehiculo.first.vehi_capacPasajeros
    end
    
    if origen == arrLugares[0] then # El trayecto de la reserva es desde el inicio del viaje  
      reservas = Reserva.joins("INNER JOIN detalle_reservas DR ON reservas.id = DR.reserva_id").where("reservas.rsrv_tipoProducto IN ('VUELO', 'VIAJE') AND reservas.rsrv_productoId = #{viaje_id} AND reservas.rsrv_trayectoViaje LIKE '#{origen}|%' AND DR.detRsrv_estadoReserva IN('C', 'B') AND reservas.rsrv_estadoRegistro = 'A' AND DR.detRsrv_estadoRegistro = 'A'").count
    elsif destino == arrLugares[arrLugares.length - 1] then # El trayecto de la reserva llega hasta el destino final del viaje
      reservas = Reserva.joins("INNER JOIN detalle_reservas DR ON reservas.id = DR.reserva_id").where("reservas.rsrv_tipoProducto IN ('VUELO', 'VIAJE') AND reservas.rsrv_productoId = #{viaje_id} AND reservas.rsrv_trayectoViaje LIKE '%|#{destino}' AND DR.detRsrv_estadoReserva IN('C', 'B') AND reservas.rsrv_estadoRegistro = 'A' AND DR.detRsrv_estadoRegistro = 'A'").count
    end
    
    sillasDisponibles = vehiCapacPasajeros - reservas
    return sillasDisponibles
  end
end
