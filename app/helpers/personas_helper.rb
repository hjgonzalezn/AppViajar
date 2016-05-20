module PersonasHelper
  def set_tipos_id_persona
    tiposIdPersona = Hash.new
    Catalogo.where("ctlg_categoria = 'TIPO DE DOCUMENTO DE IDENTIDAD' AND ctlg_subcategoria IN ('PERSONA', 'ADULTO', 'MENOR', 'TODOS') AND ctlg_estadoRegistro = 'A'").find_each do |h|
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
