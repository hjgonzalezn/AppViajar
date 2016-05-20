module EntidadTerritorialsHelper
    #Autor: @hjgonzalezn, 07-MAY-2016
    #Proporciona el id de entidad territorial padre en un determinado nivel
    def set_padre_nivel(enter_hijoId, enter_nivelPadre)
      entidadTerrPadre = EntidadTerritorial.find(enter_hijoId)

      until entidadTerrPadre.enter_nivel == enter_nivelPadre
        entidadTerrPadre = EntidadTerritorial.find(entidadTerrPadre.enter_padreId)
      end
      
      return entidadTerrPadre
    end
    
    def set_pais(enter_hijoId)
      entidadTerrResult = nil
      entidadTerr = EntidadTerritorial.find(enter_hijoId)
      if entidadTerr.enter_nivel == 2 then
        entidadTerrResult = entidadTerr 
      elsif entidadTerr.enter_nivel > 2 then
        entidadTerrResult = set_padre_nivel(enter_hijoId, 2) #nivel 2 = pais
      end 
      
      return entidadTerrResult
    end
    
    def set_continentes
      continentes = EntidadTerritorial.where("enter_nivel = 1 AND enter_estadoRegistro = 'A'")
    end
    
    #Autor: @hjgonzalezn, 09-MAY-2016
    #Encontrar la region a la que pertenece una entidad territorial
    def set_region(enter_id)
      region = nil
      index = 0
      entidadTerr = EntidadTerritorial.find(enter_id)
      
      while entidadTerr.region_id.nil? && index < 12
        index += 1
        entidadTerr = EntidadTerritorial.find(entidadTerr.enter_padreId)
      end
      
      unless entidadTerr.region_id.nil? || entidadTerr.region_id == 0 then 
        region = Region.find(entidadTerr.region_id)
      end
      
      return region 
    end
    
    def set_parental_path(enter_id, flag = false)
      arrNombres = Array.new
      parentalPath = ""
      entidadTerr = EntidadTerritorial.find(enter_id)
      
      if flag then # incluir al hijo en la ruta de entidades territoriales
        arrNombres << entidadTerr.enter_nombreCorto + " |"
      end
      
      while entidadTerr.enter_nivel > 1
        entidadTerr = EntidadTerritorial.find(entidadTerr.enter_padreId)
        arrNombres << entidadTerr.enter_nombreCorto + " |"
      end
      parentalPath = arrNombres.reverse
      return parentalPath
    end
    
    def set_paises
      paises = EntidadTerritorial.where("enter_nivel = 2 AND enter_estadoRegistro = 'A'")
    end
    
    def set_ciudades_colombia
      ciudadesCol = EntidadTerritorial.joins("INNER JOIN entidad_territorials E1 ON entidad_territorials.enter_padreId = E1.id INNER JOIN entidad_territorials E2 ON E1.enter_padreId = E2.id").where("E2.id = 3 AND E2.enter_estadoRegistro = 'A' AND E1.enter_estadoRegistro = 'A'").order(:enter_nombreCorto)
    end
    
end
