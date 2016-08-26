class AboutController < ApplicationController
  include AeropuertosHelper
  include PersonasHelper
  
  def index
    @ciudadesAeropuertos = set_ciudades_aeropuertos
  end
  
  def detalle_reserva
    #Entidad territorial Origen
    @enterOrigen = EntidadTerritorial.find(params[:cboOrigen])
    #Entidad Territorial Destino
    @enterDestino = EntidadTerritorial.find(params[:cboDestino])
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
      @enterOrigen = EntidadTerritorial.find(arrDatosViaje[0])
      @enterDestino = EntidadTerritorial.find(arrDatosViaje[1])
      @dtFechaIda = arrDatosViaje[2]
      @dtFechaRegreso = arrDatosViaje[3]
      @nroAdultos = arrDatosViaje[4].to_i
      @nroMenores = arrDatosViaje[5].to_i
      @nroInfantes = arrDatosViaje[6].to_i
    end
    
  end
  
  def registrar_reserva
    
      msj = "Apreciado(a) cliente, su solicitud de reserva ha sido enviada exitosamente. En breve sera contactado para confirmar su orden."
      
      datosContacto = params[:contacto]      
      datosReserva = params[:datos_reserva]
      datosViaje = params[:datos_viaje]
      
      datosContacto = eval(datosContacto)
      datosReserva = eval(datosReserva)
      
      UserMailer.correo_reservas(datosViaje, datosContacto, datosReserva).deliver_now
      
      respond_to do |format|
        format.html { redirect_to mensaje_path, notice: msj }
        #format.json { render action: 'mensaje', status: :created, location: @entidad }
      end
  end
  
    # Never trust parameters from the scary internet, only allow the white list through.
    def detalle_reserva_params
      params.require(:about).permit(:cboOrigen, :cboDestino, :txtFechaSalida, :txtFechaRegreso, :cboAdultos, :cboMenores, :cboInfantes)
    end  
end
