module PersonasHelper
  
  def buscar_personas(pers_documIdentidad, pers_nombres, pers_apellidos)
    
    personas = nil
    
    unless pers_documIdentidad.blank? then
      personas = Persona.where(pers_documentoIdentidad: pers_documIdentidad)
    else
      instSQL_where = "1 = 1 "
      unless pers_nombres.blank?
        if pers_nombres.include? " " then
          instSQL_where = instSQL_where + " AND pers_nombres = '" + pers_nombres + "'"
        else
          instSQL_where = instSQL_where + " AND pers_nombres LIKE '%" + pers_nombres + "%'"
        end   
      end
      
      unless pers_apellidos.blank?
        if pers_apellidos.include? " " then
          instSQL_where = instSQL_where + " AND pers_apellidos = '" + pers_apellidos + "'"
        else
          instSQL_where = instSQL_where + " AND pers_apellidos LIKE '%" + pers_apellidos + "%'"
        end
      end
      
      personas = Persona.where(instSQL_where)
    end
    
    return personas
    
  end
  
  def calcular_edad(fechaNacimiento)
    #fechaNacimiento YYYY-MM-DD
    edad = 200
    
    unless fechaNacimiento.blank?
      anioNac = fechaNacimiento.to_s[0, 4].to_i
      mesNac = fechaNacimiento.to_s[5, 7].to_i
      diaNac = fechaNacimiento.to_s[9, 10].to_i
      
      fechaActual = Time.new
      arrFecha = fechaActual.to_s.split(" ")
      arrFecha = arrFecha[0].split("-")
      anio = arrFecha[0].to_i
      mes = arrFecha[1].to_i
      dia = arrFecha[2].to_i
      
      edad = anio - anioNac
      
      if mes < mesNac then
        edad = edad - 1
      end
    end
    
    return edad
  end
  
  def grupo_edad_persona(fechaNacimiento)
    resultado = "ADULTO"

    unless fechaNacimiento.blank?
      edad = calcular_edad(fechaNacimiento)
      
      @gruposEdad.each do |key, value|
        arrValue = value.split("-")
        limInf = arrValue[0].to_i
        limSup = arrValue[1].to_i
        if edad >= limInf && edad <= limSup then
          resultado = key
          break
        end  
      end
    end
    
    return resultado
  end
  
  def set_tipos_id_persona(categoria="TODOS")
    tiposIdPersona = Hash.new
    if categoria == "TODOS" then
      condicion = ""
      registros = Catalogo.where("ctlg_categoria = 'TIPO DE DOCUMENTO DE IDENTIDAD' AND ctlg_subcategoria IN ('PERSONA', 'ADULTO', 'MENOR', 'TODOS') AND ctlg_estadoRegistro = 'A'")
    elsif categoria == "INFANTE" then
      registros = Catalogo.where("ctlg_categoria = 'TIPO DE DOCUMENTO DE IDENTIDAD' AND ctlg_ValorCdg IN ('NUIP', 'RC', 'PA') AND ctlg_estadoRegistro = 'A'")
    else
      registros = Catalogo.where("ctlg_categoria = 'TIPO DE DOCUMENTO DE IDENTIDAD' AND ctlg_subcategoria IN ('PERSONA', '" + categoria + "') AND ctlg_estadoRegistro = 'A'")
    end
    
    registros.each do |h|
      tiposIdPersona[h.ctlg_valorCdg]= h.ctlg_valorDesc
    end
    
    return tiposIdPersona
  end
  
  def set_generos_persona
    generosPersona = Hash.new
    
    Catalogo.where("ctlg_categoria = 'GENERO' AND ctlg_estadoRegistro = 'A'").find_each do |h|
      generosPersona[h.ctlg_valorCdg]= h.ctlg_valorDesc
    end
    
    return generosPersona
  end
  
  def set_estados_civiles
    estadosCiviles = Hash.new
    
    Catalogo.where("ctlg_categoria = 'ESTADO CIVIL' AND ctlg_estadoRegistro = 'A'").find_each do |h|
      estadosCiviles[h.ctlg_valorCdg]= h.ctlg_valorDesc
    end
    
    return estadosCiviles
  end
  
  def set_perfiles_laborales
    perfilesLaborales = Hash.new
    
    Catalogo.where("ctlg_categoria = 'PERFIL LABORAL' AND ctlg_estadoRegistro = 'A'").find_each do |h|
      perfilesLaborales[h.ctlg_valorCdg]= h.ctlg_valorDesc
    end
    
    return perfilesLaborales     
  end
  
end
