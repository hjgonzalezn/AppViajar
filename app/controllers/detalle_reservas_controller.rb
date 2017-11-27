class DetalleReservasController < ApplicationController
  
  include PersonasHelper
  include ActividadTuristicasHelper
  include ReservasHelper
  include ViajesHelper
  
  before_action :authenticate_user!, except: [:solicitar_reserva, :detalle_reserva, :confirmar_reserva, :registrar_reserva, :seleccionar_viaje]
  before_action :set_detalle_reserva, only: [:show, :edit, :update, :destroy]
  before_action :initialize_vars_global, only: [:index, :new, :show, :edit, :solicitar_reserva, :detalle_reserva, :confirmar_reserva, :registrar_reserva, :seleccionar_viaje]
  before_action :initialize_vars, only: [:new, :edit, :show]
  
  # GET /detalle_reservas
  # GET /detalle_reservas.json
  def index
    @detalle_reservas = DetalleReserva.all
  end

  # GET /detalle_reservas/1
  # GET /detalle_reservas/1.json
  def show
  end

  # GET /detalle_reservas/new
  def new
    @detalle_reserva = DetalleReserva.new
  end

  # GET /detalle_reservas/1/edit
  def edit
  end

  # POST /detalle_reservas
  # POST /detalle_reservas.json
  def create
    @detalle_reserva = DetalleReserva.new(detalle_reserva_params)

    respond_to do |format|
      if @detalle_reserva.save
        format.html { redirect_to @detalle_reserva, notice: 'Registro creado exitosamente.' }
        format.json { render :show, status: :created, location: @detalle_reserva }
      else
        format.html { render :new }
        format.json { render json: @detalle_reserva.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /detalle_reservas/1
  # PATCH/PUT /detalle_reservas/1.json
  def update
    respond_to do |format|
      if @detalle_reserva.update(detalle_reserva_params)
        format.html { redirect_to @detalle_reserva, notice: 'Registro actualizado exitosamente.' }
        format.json { render :show, status: :ok, location: @detalle_reserva }
      else
        format.html { render :edit }
        format.json { render json: @detalle_reserva.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /detalle_reservas/1
  # DELETE /detalle_reservas/1.json
  def destroy
    @detalle_reserva.destroy
    respond_to do |format|
      format.html { redirect_to detalle_reservas_url, notice: 'Registro eliminado exitosamente.' }
      format.json { head :no_content }
    end
  end
  
  def seleccionar_viaje
    instSQL_Joins = ""
    instSQL_Where = "1 = 1"
    
    @datosProd = params[:dPrd]
    
    #Fecha de Ida
    @dtFechaIda = params[:fchIda]
    #Fecha de Regreso
    @dtFechaRegreso = params[:fchRgr]
    #Ciudad Origen de la reserva
    @origen = params[:cboOrg]
    #Ciudad Destino de la reserva
    @destino = params[:cboDst]
    @sillasSolicitadas = params[:adt].to_i + params[:mnr].to_i 
    
    unless @dtFechaIda.blank?
      instSQL_Where = instSQL_Where + " AND viajes.viaje_fecha = STR_TO_DATE('#{@dtFechaIda}', '%d/%m/%Y')"
      instSQL_Where = instSQL_Where + " AND (R.ruta_descripcion LIKE '%#{@origen}%#{@destino}%' OR R.ruta_descripcion LIKE '%#{@destino}%#{@origen}%' )"
      instSQL_Where = instSQL_Where + " AND viajes.viaje_estadoRegistro = 'A' AND R.ruta_estadoRegistro = 'A'"
    end
    
    instSQL_Joins = "INNER JOIN ruta R ON R.id = viajes.viaje_ruta"
    @viajeIda = Viaje.select("viajes.id, viajes.viaje_fecha, viajes.viaje_horaSalida, R.ruta_descripcion").joins(instSQL_Joins).where(instSQL_Where).take
    #Sillas disponibles en el viaje de ida
    @sillasDisponIda = 0
    #Sillas disponibles en el viaje de regreso
    @sillasDisponRgr = 0
    
    unless @viajeIda.nil?
      @sillasDisponIda = sillas_disponibles(@viajeIda.id, @viajeIda.ruta_descripcion, params[:cboOrg], params[:cboDst])
    end
 
    # if @sillasDisponibles >= (params[:cboAdlt] + params[:cboMnr]).to_i then
    #       
    # end
    
    instSQL_Where = "1 = 1"
    
    unless @dtFechaRegreso.blank?
      instSQL_Where = instSQL_Where + " AND viajes.viaje_fecha = STR_TO_DATE('#{@dtFechaRegreso}', '%d/%m/%Y')"
      instSQL_Where = instSQL_Where + " AND (R.ruta_descripcion LIKE '%#{params[:cboOrg]}%#{params[:cboDst]}%' OR R.ruta_descripcion LIKE '%#{params[:cboDst]}%#{params[:cboOrg]}%' )"
      instSQL_Where = instSQL_Where + " AND viajes.viaje_estadoRegistro = 'A' AND R.ruta_estadoRegistro = 'A'"
    end
    
    @viajeRegreso = Viaje.select("viajes.id, viajes.viaje_fecha, viajes.viaje_horaSalida, R.ruta_descripcion").joins(instSQL_Joins).where(instSQL_Where).take
    
    unless @viajeRegreso.nil?
      @sillasDisponRgr = sillas_disponibles(@viajeRegreso.id, @viajeRegreso.ruta_descripcion, params[:cboOrg], params[:cboDst])
    end
    
    #Entidad territorial Origen
    unless params[:cboOrg].blank?
      @enterOrigen = EntidadTerritorial.find(params[:cboOrg])
    end
    
    @enterDestino = EntidadTerritorial.new
    unless params[:cboDst].blank?
      @enterDestino = nil
      #Entidad Territorial Destino
      @enterDestino = EntidadTerritorial.find(params[:cboDst])
      instSQL_Joins = "INNER JOIN tarifas T ON (T.trf_conceptoAplicacion = 'RUTA' AND ruta.id = T.trf_producto)"
      instSQL_Where = "ruta_descripcion = '#{params[:cboOrg]}|#{params[:cboDst]}' AND ruta.ruta_estadoRegistro = 'A'"
      @ruta = Rutum.select("ruta.*, T.trf_base tarifa").joins(instSQL_Joins).where(instSQL_Where).take
    end
    
    @adultos = params[:adt].to_i
    @menores = params[:mnr].to_i
    @infantes = params[:inf].to_i
  end
  
  def solicitar_reserva
    
    if params[:dPrd].nil?
      respond_to do |format|
        format.html { redirect_to home_path }
        #format.json { render action: 'mensaje', status: :created, location: @entidad }
      end      
    else
      @datosProducto = params[:dPrd].split("|")
      @tipoProducto = @datosProducto[0]
      @idProducto = ""
      
      case @tipoProducto
        when "VUELO" then
          @producto = "DATOS DEL " + @tipoProducto
          @idProducto = params[:vjIda] + "-" + params[:vjRgr] 
        when "PAQUETUR" then
          paquete = PaqueteTuristico.find(@idProducto)
          @producto = "PLAN " + paquete.pqTur_nombre
          @idProducto = @datosProducto[1]  
      end
      
      #Entidad territorial Origen
      @enterOrigen = EntidadTerritorial.find(params[:org])
      @enterDestino = EntidadTerritorial.new
      unless params[:dst].blank?
        @enterDestino.destroy
        #Entidad Territorial Destino
        @enterDestino = EntidadTerritorial.find(params[:dst])
      end
      #Fecha de Ida
      @dtFechaIda = params[:fchIda]
      #Fecha de Regreso
      @dtFechaRegreso = params[:fchRgr]
      @tiposIdAdulto = set_tipos_id_persona("ADULTO")
      @tiposIdMenor = set_tipos_id_persona("MENOR")
      @tiposIdInfante = set_tipos_id_persona("INFANTE")
      @adultos = params[:adt].to_i
      @menores = params[:mnr].to_i
      @infantes = params[:inf].to_i
    end
  end
  
  def confirmar_reserva
    @datosContacto = params[:contacto]
    @datosReserva = params[:reserva]
    @datosViaje = params[:datos_viaje]
    #ID de cada pasajero
    paxIds = ""
    
    @datosReserva[:tipo_identificacion].each_with_index do |tipoId, i|
      paxIds = paxIds + "'" + @datosReserva[:numero_identificacion][i] + tipoId + "'," 
    end
    paxIds = paxIds[0, paxIds.length - 1]

    #Verifica si el pasajero ya tiene una reserva en el viaje de ida
    #incluir en la validacion el trayecto del pasajero
    #@reservasExistentes = DetalleReserva.joins("reservas R ON detalle_reservas.reserva_id = R.id INNER JOIN viajes V ON (V.id = R.rsrv_productoId AND R.rsrv_tipoProducto IN ('VIAJE','VUELO'))").where("detRsrv_clienteId IN (#{paxIds})")
    
    if params[:datos_viaje].nil?
      respond_to do |format|
        format.html { redirect_to home_path }
        #format.json { render action: 'mensaje', status: :created, location: @entidad }
      end      
    else
      arrDatosViaje = params[:datos_viaje].split("|")
      @producto = arrDatosViaje[0]
      @enterOrigen = EntidadTerritorial.find(arrDatosViaje[1])
      
      unless arrDatosViaje[2].blank?
        @enterDestino = EntidadTerritorial.find(arrDatosViaje[2])
      end
      
      @dtFechaIda = arrDatosViaje[3]
      @dtFechaRegreso = arrDatosViaje[4]
      @nroAdultos = arrDatosViaje[5].to_i
      @nroMenores = arrDatosViaje[6].to_i
      @nroInfantes = arrDatosViaje[7].to_i
      @idProducto = arrDatosViaje[8]
    end
    
    if @producto.include? "PLAN" then
      @actividadesPlan = set_actividades_plan(@idProducto.to_i)
    end
  end
  
  def registrar_reserva
    
      msj = "Apreciado(a) cliente, su solicitud de reserva ha sido enviada exitosamente. En breve sera contactado para confirmar su orden."
      
      datosContacto = params[:contacto]      
      datosReserva = params[:datos_reserva]
      datosViaje = params[:datos_viaje]
      opcionalesReserva = params[:opcionales]
      tarifaDefMenor = 0
      tarifaDefAdulto = 0
      valorTotalReserva = 0
      
      arrViaje = datosViaje.split("|")
      enterOrigen = EntidadTerritorial.find(arrViaje[1])
      enterDestino = EntidadTerritorial.find(arrViaje[2])
      arrFecha = arrViaje[3].split("/")
      fechaIda = arrFecha[2].to_s + "-" + arrFecha[1].to_s + "-" + arrFecha[0].to_s
      arrFecha = arrViaje[4].split("/")
      fechaRegreso = arrFecha[2].to_s + "-" + arrFecha[1].to_s + "-" + arrFecha[0].to_s
      
      if datosViaje.include? "VUELO" then
        producto = "VUELO"
        arrProductosId = arrViaje[8].split("-")
        tarifas = Tarifa.select("tarifas.trf_base, tarifas.trf_promo, tarifas.trf_econo, tarifas.trf_flexi, tarifas.trf_deluxe").joins("INNER JOIN ruta R ON (tarifas.trf_tipoProducto = 'RUTA' AND tarifas.trf_producto = R.id) ").where("tarifas.trf_conceptoCodigo = 'VLPAX' AND tarifas.trf_estadoRegistro = 'A' AND R.ruta_estadoRegistro = 'A' AND R.ruta_descripcion = '#{arrViaje[1]}|#{arrViaje[2]}'")
        tarifas.each do |t|
          tarifaDefAdulto = t.trf_base
          tarifaDefMenor = t.trf_base
        end
        # str_select = "Viajes.id viaje_id, Viajes.viaje_fecha, Viajes.viaje_trayecto, R.id ruta_id, R.ruta_descripcion"
        # str_condiciones = "(viaje_fecha = STR_TO_DATE('#{fechaIda}', '%Y-%m-%d') OR viaje_fecha = STR_TO_DATE('#{fechaRegreso}', '%Y-%m-%d')) AND viaje_estado IN('PROG', 'CONF') AND viaje_estadoRegistro = 'A' AND R.ruta_estadoRegistro = 'A'"
        # str_condiciones = str_condiciones + " AND R.ruta_descripcion LIKE '%#{enterOrigen.id.to_s}%' AND R.ruta_descripcion LIKE '%#{enterDestino.id.to_s}%'"
        # str_joins = "INNER JOIN Ruta R ON Viajes.viaje_ruta = R.id"
        #         
        # viajes = Viaje.select(str_select).where(str_condiciones).joins(str_joins)
                
        #Inner join ruta
        # viajes.each do |h|
#          
          # #Viaje de ida
          # if fechaIda == h.viaje_fecha.to_s then
            # if h.ruta_descripcion.index(enterOrigen.id.to_s) < h.ruta_descripcion.index(enterDestino.id.to_s) then
              # idProducto = h.viaje_id
            # else
              # if h.viaje_trayecto == "RT" then
                # if h.ruta_descripcion.index(enterDestino.id.to_s) < h.ruta_descripcion.index(enterOrigen.id.to_s) then
                  # idProducto = h.viaje_id
                # end
              # end
            # end
          # end
#           
          # #Viaje de regreso
          # if fechaRegreso == h.viaje_fecha then
            # if h.ruta_descripcion.index(enterOrigen.id.to_s) > h.ruta_descripcion.index(enterDestino.id.to_s) then
              # idProducto = h.viaje_id
            # else
              # if h.viaje_trayecto == "RT" then
                # if h.ruta_descripcion.index(enterDestino.id.to_s) > h.ruta_descripcion.index(enterOrigen.id.to_s) then
                  # idProducto = h.viaje_id
                # end
              # end
            # end
          # end
        # end
        
      elsif datosViaje.include? "PLAN" then
        producto = "PLAN"
        idProducto = arrViaje[8]
      end
      
      tiposDocumIdent = Catalogo.where(ctlg_categoria: "TIPO DE DOCUMENTO DE IDENTIDAD")
      
      datosContacto = eval(datosContacto)
      datosReserva = eval(datosReserva)
      
      idContacto = datosContacto["numero_identificacion"].to_s + datosContacto["tipo_identificacion"]
      
      #Tomando los datos de la reserva
      persona = Persona.where(pers_documentoIdentidad: idContacto)
      
      #Crear persona > Contacto
      if persona.size == 0 then
        persona = Persona.new
        persona.pers_estadoRegistro = "A"
        persona.pers_documentoIdentidad = idContacto #reserva.rsrv_contactoId
        persona.pers_nombres = datosContacto["nombres"]
        persona.pers_apellidos = datosContacto["apellidos"]
        persona.pers_telefonoPersonal1 = datosContacto["telefono"]
        persona.pers_correoElectrPersonal = datosContacto["correo_electronico"]
        persona.save
      else
        persona.first.pers_telefonoPersonal1 = datosContacto["telefono"]
        persona.first.pers_correoElectrPersonal = datosContacto["correo_electronico"]
        persona.first.save
      end
      
      #Verificando los datos de personas existentes
      cadenaIds = ""
      datosReserva["tipo_identificacion"].each_index{|h| cadenaIds = cadenaIds + "'" + datosReserva["numero_identificacion"][h] + datosReserva["tipo_identificacion"][h] + "',"}
      
      unless cadenaIds.blank?
        cadenaIds = cadenaIds[0, cadenaIds.length - 1]
        persExistentes = Persona.where("pers_documentoIdentidad IN (#{cadenaIds})")
        
        #Creando las personas no registradas en la base de datos
        personasIds = []
        fechasNacimiento = []
        
        for nmIndex in 0..datosReserva["tipo_identificacion"].length - 1
          flagInsert = true
          personasIds << datosReserva["numero_identificacion"][nmIndex] + datosReserva["tipo_identificacion"][nmIndex]
          arrFechaNac = datosReserva["fecha_nacimiento"][nmIndex].split("/")
          fechasNacimiento << arrFechaNac[2].to_s + "-" + arrFechaNac[1].to_s + "-" + arrFechaNac[0].to_s  
          
          persExistentes.each do |h|
            if h.pers_documentoIdentidad == personasIds.last then
              flagInsert = false
            end
          end
          
          if flagInsert then
            persona = Persona.new
            persona.pers_documentoIdentidad = personasIds.last
            persona.pers_nombres = datosReserva["nombres"][nmIndex]
            persona.pers_apellidos = datosReserva["apellidos"][nmIndex]
            unless datosReserva["fecha_nacimiento"][nmIndex].blank?
              persona.pers_fechaNacimiento = datosReserva["fecha_nacimiento"][nmIndex]
            end
            persona.pers_estadoRegistro = "A"
            persona.save
          end 
        end
      end 
      
      arrProductosId.each do |prodId|
        #Creando la reserva
        valorTotalReserva = 0
        reserva = Reserva.new
        reserva.rsrv_codigo = SecureRandom.uuid[0,5].upcase
        reserva.rsrv_tipoContacto = "P"
        reserva.rsrv_contactoId = datosContacto["numero_identificacion"] + datosContacto["tipo_identificacion"]
        reserva.rsrv_tipoProducto = producto
        reserva.rsrv_productoId = prodId
        reserva.rsrv_estadoReserva = "I"
        reserva.rsrv_estadoRegistro = "A"
        reserva.rsrv_fechaVencimiento = Time.now + (5 * 3600) #5 horas de plazo
        reserva.rsrv_fechaIda = fechaIda
        reserva.rsrv_fechaRegreso = fechaRegreso
        
        if prodId == arrProductosId.first then
          reserva.rsrv_trayectoViaje = enterOrigen.id.to_s + "|" + enterDestino.id.to_s
        else
          reserva.rsrv_trayectoViaje = enterDestino.id.to_s + "|" + enterOrigen.id.to_s
        end
        
        reserva.created_by = "HJGONZALEZ" #current_user.email.split("@")[0]
        reserva.updated_by = "HJGONZALEZ" #current_user.email.split("@")[0]
        reserva.save
      
        tarifaDef = 0
        valorOpcionalesAdulto = 0
        valorOpcionalesMenor = 0
      
        if datosViaje.include? "PLAN" then
        
          rsrv = Reserva.select("(rsrv_fechaRegreso - rsrv_fechaIda + 1) dias").where("id = ?", reserva.id).take
          tarifasPlan = tarifas_plan(reserva.rsrv_productoId)
          claveTarifa = (rsrv.dias.to_s + "D/" + (rsrv.dias - 1).to_s + "N").gsub(".0", "")
          idsActivOpcionales = ""
          
          unless opcionalesReserva.nil?
            opcionalesReserva.each do |h|
              servOpcReserva = ActividadTuristicaReserva.new
              servOpcReserva.actividad_turistica_id = h.to_i
              servOpcReserva.reserva_id = reserva.id
              servOpcReserva.atr_estadoRegistro = "A"
              servOpcReserva.save
              idsActivOpcionales = idsActivOpcionales + h + ","  
            end
          
            #Actividades opcionales
          
            idsActivOpcionales = idsActivOpcionales[0, idsActivOpcionales.length - 1] 
            instSQL_select = "T.trf_base"
            instSQL_where = "ATR.actividad_turistica_id IN (" + idsActivOpcionales + ") AND ATR.reserva_id = " + reserva.id.to_s + " AND atr_estadoRegistro = 'A' AND T.trf_estadoRegistro = 'A'"
            instSQL_joins = "AS ATR INNER JOIN tarifas T ON (T.trf_conceptoCodigo = 'VACTUR' AND T.trf_tipoProducto = 'ACTIVIDAD_TURISTICAS' AND T.trf_producto = ATR.actividad_turistica_id)"
          
  
            activOpcionales = ActividadTuristicaReserva.select(instSQL_select).where(instSQL_where).joins(instSQL_joins)
          
            #Calculando el valor total por individuo de las actividades opcionales
            activOpcionales.each do |j|
              valorOpcionalesAdulto += j.trf_base
              valorOpcionalesMenor += j.trf_base  
            end
          end
        
          # log = Log.new
          # log.log_operacion = "ProductoID = " + reserva.rsrv_productoId.to_s
          # log.log_resultOperacion = "Clave Tarifa = " + claveTarifa 
          # log.log_equipo = tarifasPlan.length
          # log.save
                
          tarifasPlan.each do |h|
            if h.trf_detalleAplicacion == claveTarifa then
            
              case h.trf_conceptoAplicacion
                when "ADULTO" then
                  tarifaDefAdulto = h.trf_base
                when "MENOR" then
                  tarifaDefMenor = h.trf_base
              end
            end
          end
        end #Plan
      
        # log = Log.new
        # log.log_operacion = "Adulto " + tarifaDefAdulto.to_s
        # log.log_resultOperacion = "Menor " + tarifaDefMenor.to_s
        # log.save
      
        #Creando los detalles de la reserva
        index = 0
        
        personasIds.each do |h|
          tarifaDef = 0
          grupoEdad = grupo_edad_persona(fechasNacimiento[index])
          if datosViaje.include? "PLAN" then
            unless grupoEdad == "INFANTE" then
              if grupoEdad == "ADULTO" then
                tarifaDef = tarifaDefAdulto + valorOpcionalesAdulto 
              elsif grupoEdad == "MENOR" then
                tarifaDef = tarifaDefMenor + valorOpcionalesMenor
              end 
            end
          else
            unless grupoEdad == "INFANTE" then
              if grupoEdad == "ADULTO" then
                tarifaDef = tarifaDefAdulto 
              elsif grupoEdad == "MENOR" then
                tarifaDef = tarifaDefMenor
              end 
            end
          end
        
          # log = Log.new
          # log.log_operacion = "Grupo Edad " + tarifaDef.to_s
          # log.log_resultOperacion = "Tarifa Def " + tarifaDef.to_s
          # log.save
    
          detalleReserva = DetalleReserva.new
          detalleReserva.reserva_id = reserva.id
          detalleReserva.detRsrv_tipoCliente = "P" #Persona
          detalleReserva.detRsrv_estadoReserva = "I"
          detalleReserva.detRsrv_estadoRegistro = "A"
          detalleReserva.detRsrv_clienteId = h
          detalleReserva.detRsrv_tarifaCodigo = "BASE"
          detalleReserva.detRsrv_valor = tarifaDef
          detalleReserva.created_by = "HJGONZALEZ" #current_user.email.split("@")[0]
          detalleReserva.updated_by = "HJGONZALEZ" #current_user.email.split("@")[0]
          detalleReserva.save
          index += 1
          valorTotalReserva += tarifaDef
        end
      
        reserva.rsrv_valorTotal = valorTotalReserva
        reserva.save 
      end # Ciclo productos_id
              
      UserMailer.correo_reservas(datosViaje, datosContacto, datosReserva).deliver_now
      
      respond_to do |format|
        format.html { redirect_to mensaje_path, notice: msj }
        #format.json { render action: 'mensaje', status: :created, location: @entidad }
      end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_detalle_reserva
      @detalle_reserva = DetalleReserva.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def detalle_reserva_params
      params.require(:detalle_reserva).permit(:reserva_id, :detRsrv_estadoReserva, :detRsrv_tipoCliente, :detRsrv_clienteId, :detRsrv_tarifaCodigo, :detRsrv_valor, :detRsrv_estadoRegistro, :created_by, :updated_by)
    end
end
