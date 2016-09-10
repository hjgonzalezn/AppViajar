class UserMailer < ActionMailer::Base
  default from: "portal@hotelcarolinadelmar.com.co"
  
  def correo_reservas(datosViaje, datosContacto, datosReserva)
    @datosReserva = datosReserva
    @datosContacto = datosContacto
    arrDatosViaje = datosViaje.split("|")
    @producto = arrDatosViaje[0]
    @enterOrigen = EntidadTerritorial.find(arrDatosViaje[1])
    unless arrDatosViaje[2].blank?
      @enterDestino = EntidadTerritorial.find(arrDatosViaje[2])
    end
    @dtFechaIda = arrDatosViaje[3]
    @dtFechaRegreso = arrDatosViaje[4]
    @nroAdultos = arrDatosViaje[5]
    @nroMenores = arrDatosViaje[6]
    @nroInfantes = arrDatosViaje[7]
    
    asuntoCorreo = "Reserva " + @producto
    
    if Rails.env.production?
      mail(to:"agencia@naisatours.co", subject: asuntoCorreo )
    else
      mail(to:"hjgonzalez@naisatours.co", subject: asuntoCorreo )
    end
  end
  
  def correo_contacto(hshMensaje)
    @tipoMensaje = hshMensaje["tipo_mensaje"]
    @asunto = hshMensaje["asunto"]
    @remitente = hshMensaje["remitente"]
    @correoCliente = hshMensaje["correo"]
    @telefono = hshMensaje["telefono"]
    @contenido = hshMensaje["contenido"]
    
    if Rails.env.production?
       mail(to:"agencia@naisatours.co", subject: @asunto + " - " + @remitente.upcase)
    else
       mail(to:"hjgonzalez@naisatours.co", subject: @asunto + " - " + @remitente.upcase)
    end    
  end
  
end
