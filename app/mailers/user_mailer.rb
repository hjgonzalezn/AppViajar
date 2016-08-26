class UserMailer < ActionMailer::Base
  default from: "portal@hotelcarolinadelmar.com.co"
  
  def correo_reservas(datosViaje, datosContacto, datosReserva)
    @datosReserva = datosReserva
    @datosContacto = datosContacto
    arrDatosViaje = datosViaje.split("|")
    @enterOrigen = EntidadTerritorial.find(arrDatosViaje[0])
    @enterDestino = EntidadTerritorial.find(arrDatosViaje[1])
    @dtFechaIda = arrDatosViaje[2]
    @dtFechaRegreso = arrDatosViaje[3]
    @nroAdultos = arrDatosViaje[4]
    @nroMenores = arrDatosViaje[5]
    @nroInfantes = arrDatosViaje[6]
    
    asuntoCorreo = "Reserva " + @enterOrigen.enter_nombreCorto + " - " + @enterDestino.enter_nombreCorto
    
    if Rails.env.production?
      mail(to:"agencia@naisatours.co", subject: asuntoCorreo )
    else
      mail(to:"hjgonzalez@naisatours.co", subject: asuntoCorreo )
    end
  end
  
  # def correo_contactenos(datosSolicitud)
    # @datosSolicitud = datosSolicitud
    # if Rails.env.production?
      # mail(to:"info@hotelcarolinadelmar.com.co", subject: @datosSolicitud[:TipoMensaje] + " " + @datosSolicitud[:Nombre].upcase)
    # else
      # mail(to:"hjgonzalezn@gmail.com", subject: @datosSolicitud[:TipoMensaje] + " " + @datosSolicitud[:Nombre].upcase)
    # end    
  # end
end
