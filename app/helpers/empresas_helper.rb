module EmpresasHelper
  def set_tipos_id_empresa
    tiposIdentEmpresa = Hash.new
    # Carga los tipos de identificación para empresas
    Catalogo.where("ctlg_categoria = 'TIPO DE DOCUMENTO DE IDENTIDAD' AND ctlg_subcategoria IN ('EMPRESA', 'TODOS') AND ctlg_estadoRegistro = 'A'").find_each do |h|
      tiposIdentEmpresa[h.ctlg_valorCdg]= h.ctlg_valorDesc
    end
      
      return tiposIdentEmpresa
  end
  
  def set_sucursales_empresa(empr_documentoIdentidad)
    sucursales_empresa = SucursalEmpresa.where("empr_documentoIdentidad = ? AND sucEmp_estadoRegistro = 'A'", empr_documentoIdentidad).order(:sucEmpr_nombreSucursal)
  end
end
