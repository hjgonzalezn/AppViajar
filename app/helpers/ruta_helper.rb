module RutaHelper
  def set_descripcion_ruta(ruta_ciudades_ids)
     arrDescrip = ruta_ciudades_ids.split("|") 
     descripcionRuta = "" 
     arrDescrip.each do |id| 
       entidadTerr = EntidadTerritorial.find(id) 
       descripcionRuta = descripcionRuta == "" ? entidadTerr.enter_nombreCorto : descripcionRuta + " - " + entidadTerr.enter_nombreCorto   
     end 
     
     return descripcionRuta
  end
  
  def set_descripcion_ruta_aeroptos(ruta_ciudades_ids)
     arrDescrip = ruta_ciudades_ids.split("|") 
     descripcionRuta = "" 
     arrDescrip.each do |id| 
       aeropuerto = Aeropuerto.where(aeropt_ciudadCdg: id).take 
       descripcionRuta = descripcionRuta == "" ? aeropuerto.aeropt_codigoIATA : descripcionRuta + " - " + aeropuerto.aeropt_codigoIATA   
     end
     
     return descripcionRuta
  end
end
