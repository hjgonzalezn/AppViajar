class DetalleReservasController < ApplicationController
  
  include PersonasHelper
  
  before_action :set_detalle_reserva, only: [:show, :edit, :update, :destroy]
  before_action :initialize_vars_global, only: [:index, :new, :show, :edit, :solicitar_reserva, :detalle_reserva, :confirmar_reserva]
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

  def solicitar_reserva
    
    if params[:datosProducto].nil?
      respond_to do |format|
        format.html { redirect_to home_path }
        #format.json { render action: 'mensaje', status: :created, location: @entidad }
      end      
    else
      @datosProducto = params[:datosProducto].split("|")
      @tipoProducto = @datosProducto[0]
      idProducto = @datosProducto[1]
      
      case @tipoProducto
        when "VUELO" then
          @producto = "DATOS DEL " + @tipoProducto
        when "PAQUETUR" then
          paquete = PaqueteTuristico.find(idProducto)
          @producto = "PLAN " + paquete.pqTur_nombre  
      end
      
      #Entidad territorial Origen
      @enterOrigen = EntidadTerritorial.find(params[:cboOrigen])
      @enterDestino = EntidadTerritorial.new
      unless params[:cboDestino].blank?
        @enterDestino.destroy
        #Entidad Territorial Destino
        @enterDestino = EntidadTerritorial.find(params[:cboDestino])
      end
      #Fecha de Ida
      @dtFechaIda = params[:txtFechaIda]
      #Fecha de Regreso
      @dtFechaRegreso = params[:txtFechaRegreso]
      @tiposIdAdulto = set_tipos_id_persona("ADULTO")
      @tiposIdMenor = set_tipos_id_persona("MENOR")
      @tiposIdInfante = set_tipos_id_persona("INFANTE")
      @nroAdultos = params[:cboAdultos].to_i
      @nroMenores = params[:cboMenores].to_i
      @nroInfantes = params[:cboInfantes].to_i
    end
  end
  
  def confirmar_reserva
    @datosContacto = params[:contacto]
    @datosReserva = params[:reserva]
    @datosViaje = params[:datos_viaje]
    
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
    end
    
  end
  
  def registrar_reserva
    
      msj = "Apreciado(a) cliente, su solicitud de reserva ha sido enviada exitosamente. En breve sera contactado para confirmar su orden."
      
      datosContacto = params[:contacto]      
      datosReserva = params[:datos_reserva]
      datosViaje = params[:datos_viaje]
      
      if datosViaje.include? "VUELO" then
        producto = "VUELO"
        arrViaje = datosViaje.split("|")
        enterOrigen = EntidadTerritorial.find(arrViaje[1])
        enterDestino = EntidadTerritorial.find(arrViaje[2])
        arrFecha = arrViaje[3].split("/")
        fechaIda = arrFecha[2].to_s + "-" + arrFecha[1].to_s + "-" + arrFecha[0].to_s
        arrFecha = arrViaje[4].split("/")
        fechaRegreso = arrFecha[2].to_s + "-" + arrFecha[1].to_s + "-" + arrFecha[0].to_s
        
        str_select = "Viajes.id viaje_id, Viajes.viaje_fecha, Viajes.viaje_trayecto, R.id ruta_id, R.ruta_descripcion"
        str_condiciones = "(viaje_fecha = STR_TO_DATE('#{fechaIda}', '%Y-%m-%d') OR viaje_fecha = STR_TO_DATE('#{fechaRegreso}', '%Y-%m-%d')) AND viaje_estado IN('PROG', 'CONF') AND viaje_estadoRegistro = 'A' AND R.ruta_estadoRegistro = 'A'"
        str_condiciones = str_condiciones + " AND R.ruta_descripcion LIKE '%#{enterOrigen.id.to_s}%' AND R.ruta_descripcion LIKE '%#{enterDestino.id.to_s}%'"
        str_joins = "INNER JOIN Ruta R ON Viajes.viaje_ruta = R.id"
        
        viajes = Viaje.select(str_select).where(str_condiciones).joins(str_joins)
        idProducto = nil
        
        #Inner join ruta
        viajes.each do |h|
          #puts ">>>>>>>>>>>>>>>>>>>>>>>>>>"
          #puts fechaIda
          #puts fechaRegreso
          #puts h.viaje_fecha
          # puts h.ruta_descripcion.index(enterOrigen.id.to_s)
          # puts h.ruta_descripcion.index(enterDestino.id.to_s)
          
          #Viaje de ida
          if fechaIda == h.viaje_fecha.to_s then
            if h.ruta_descripcion.index(enterOrigen.id.to_s) < h.ruta_descripcion.index(enterDestino.id.to_s) then
              idProducto = h.viaje_id
            else
              if h.viaje_trayecto == "RT" then
                if h.ruta_descripcion.index(enterDestino.id.to_s) < h.ruta_descripcion.index(enterOrigen.id.to_s) then
                  idProducto = h.viaje_id
                end
              end
            end
          end
          
          #Viaje de regreso
          if fechaRegreso == h.viaje_fecha then
            if h.ruta_descripcion.index(enterOrigen.id.to_s) > h.ruta_descripcion.index(enterDestino.id.to_s) then
              idProducto = h.viaje_id
            else
              if h.viaje_trayecto == "RT" then
                if h.ruta_descripcion.index(enterDestino.id.to_s) > h.ruta_descripcion.index(enterOrigen.id.to_s) then
                  idProducto = h.viaje_id
                end
              end
            end
          end
        end
        
      elsif datosViaje.include? "PLAN" then
        producto = "PLAN"
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
        
        for nmIndex in 0..datosReserva["tipo_identificacion"].length - 1
          flagInsert = true
          personasIds << datosReserva["numero_identificacion"][nmIndex] + datosReserva["tipo_identificacion"][nmIndex]
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
            persona.pers_estadoRegistro = "A"
            persona.save
          end 
        end
      end 
      
      #Creando la reserva
      reserva = Reserva.new
      reserva.rsrv_codigo = SecureRandom.uuid[0,5].upcase
      reserva.rsrv_tipoContacto = "P"
      reserva.rsrv_contactoId = datosContacto["numero_identificacion"] + datosContacto["tipo_identificacion"]
      reserva.rsrv_tipoProducto = producto
      reserva.rsrv_productoId = idProducto
      reserva.rsrv_estadoReserva = "I"
      reserva.rsrv_estadoRegistro = "A"
      reserva.rsrv_fechaVencimiento = Time.now + (5 * 3600) #5 horas de plazo
      reserva.rsrv_fechaIda = fechaIda
      reserva.rsrv_fechaRegreso = fechaRegreso
      reserva.rsrv_trayectoViaje = enterOrigen.id.to_s + "|" + enterDestino.id.to_s
      reserva.created_by ="NAISATOURS"
      reserva.updated_by ="NAISATOURS"
      reserva.save
      
      #Creando los detalles de la reserva
      personasIds.each do |h|
        #Verificando si la persona ya tiene reserva para en esa fecha y ruta
        detalleReserva = DetalleReserva.new
        detalleReserva.reserva_id = reserva.id
        detalleReserva.detRsrv_tipoCliente = "P" #Persona
        detalleReserva.detRsrv_estadoReserva = 'I'
        detalleReserva.detRsrv_estadoRegistro = 'A'
        detalleReserva.detRsrv_clienteId = h
        detalleReserva.created_by ="NAISATOURS"
        detalleReserva.updated_by ="NAISATOURS"
        detalleReserva.save
      end
      
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