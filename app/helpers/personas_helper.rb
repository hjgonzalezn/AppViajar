module PersonasHelper
  def set_tipos_id_persona
    tiposIdPersona = Hash.new
    Catalogo.where("ctlg_categoria = 'TIPO DE DOCUMENTO DE IDENTIDAD' AND ctlg_subcategoria IN ('PERSONA', 'ADULTO', 'MENOR', 'TODOS') AND ctlg_estadoRegistro = 'A'").find_each do |h|
      tiposIdPersona[h.ctlg_valorCdg]= h.ctlg_valorDesc
    end
    
    return tiposIdPersona
  end
  
end
