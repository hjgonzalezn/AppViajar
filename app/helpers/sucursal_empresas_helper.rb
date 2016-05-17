module SucursalEmpresasHelper
  # Carga los tipos de sucursal de una empresa: principal o secundaria
  def set_tipos_sucursal
    tiposSucursal = Hash.new
    Catalogo.where("ctlg_categoria = 'TIPO DE SUCURSAL' AND ctlg_subcategoria = 'EMPRESA' AND ctlg_estadoRegistro = 'A'").find_each do |h|
      tiposSucursal[h.ctlg_valorCdg]= h.ctlg_valorDesc
    end
    
    return tiposSucursal
  end
end
