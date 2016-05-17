module AeropuertosHelper
  def set_ciudades_aeropuertos
    ciudades = EntidadTerritorial.joins("INNER JOIN aeropuertos A ON entidad_territorials.id = A.aeropt_ciudadCdg").where("A.aeropt_estadoRegistro = 'A' AND entidad_territorials.enter_estadoRegistro = 'A' ").order("entidad_territorials.enter_nombreOficial")
    return ciudades
  end
end
