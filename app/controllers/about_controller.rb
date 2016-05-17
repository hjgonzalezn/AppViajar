class AboutController < ApplicationController
  include AeropuertosHelper
  
  def index
    @ciudadesAeropuertos = set_ciudades_aeropuertos
  end
  
  def datos_reserva
  end
end
