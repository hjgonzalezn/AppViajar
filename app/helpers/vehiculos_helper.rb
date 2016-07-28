module VehiculosHelper
  def set_tipos_vehiculo
    tiposVehiculo = Hash.new
    registros = Catalogo.where("ctlg_categoria = 'TIPO DE VEHÍCULO' AND ctlg_estadoRegistro = 'A'").order(:ctlg_valorDesc)
    registros.each do |h|
      tiposVehiculo[h.ctlg_valorCdg]= h.ctlg_valorDesc
    end
    
    return tiposVehiculo
  end
  
  def set_propietario_vehiculo(tipoPropietario, documentoIdentidad, sucursal)
    datosPropietario = Hash.new
    datosPropietario["nombre"] = ""
    datosPropietario["ciudad"] = ""
    
    unless documentoIdentidad.nil? 
      if tipoPropietario == "EMPRESA" then 
        empresa = Empresa.where(empr_documentoIdentidad: documentoIdentidad).take 
        datosPropietario["nombre"] = empresa == nil ? nil : empresa.empr_nombreCorto
         
        unless sucursal.nil? 
          sucursal = SucursalEmpresa.find(sucursal) 
          ciudad = EntidadTerritorial.find(sucursal.sucEmpr_ciudadDomicilio)
          datosPropietario["ciudad"] = ciudad == nil ? ciudad : ciudad.enter_nombreCorto 
        end 
      elsif tipoPropietario == "ADULTO" then 
        persona = Persona.where(pers_documentoIdentidad: documentoIdentidad).take 
        unless persona.pers_ciudadDomicilio.nil? 
          ciudad = EntidadTerritorial.find(persona.pers_ciudadDomicilio) 
          datosPropietario["ciudad"] = ciudad == nil ? ciudad : ciudad.enter_nombreCorto 
        end 
        datosPropietario["nombre"] = persona.pers_nombres + " " + persona.pers_apellidos 
      end 
    end
    
    return datosPropietario
     
  end
end
