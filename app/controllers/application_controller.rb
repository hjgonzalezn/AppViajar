class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  def initialize_vars_global
    @meses = {1 => "Ene", 2 => "Feb", 3 => "Mar", 4 => "Abr", 5 => "May", 6 =>  "Jun", 7 => "Jul", 8 => "Ago", 9 => "Sep", 10 => "Oct", 11 => "Nov", 12 => "Dic" }
    @estados = Hash.new
    @tiposDocumIdent = Hash.new
    @slideShow = Hash.new
    @gruposEdad = Hash.new
    
    todoCatalogo = Catalogo.where("ctlg_estadoRegistro = ?", "A")
    
    todoCatalogo.each do |h|
      if h.ctlg_categoria == "ESTADO DE REGISTRO" then
        @estados[h.ctlg_valorCdg] = h.ctlg_valorDesc
      elsif h.ctlg_categoria == "TIPO DE DOCUMENTO DE IDENTIDAD" then
        # Tipos de documento de identidad
        @tiposDocumIdent[h.ctlg_valorCdg] = h.ctlg_valorDesc
      elsif h.ctlg_categoria == "RANGO DE EDAD" then
        #Grupo de edad
        @gruposEdad[h.ctlg_valorDesc] = h.ctlg_observacion
      end
      
    end
    
    modeloAccion = ModeloAccion.select("M.mdl_nombre, A.acc_nombre, modelo_accions.modAcc_sliderShow").joins("INNER JOIN modelos M ON M.id = modelo_accions.modelo_id INNER JOIN accions A ON A.id = modelo_accions.accion_id").where("modelo_accions.modAcc_estadoRegistro = ?", "A")
    
    modeloAccion.each do |h|
      @slideShow[h.mdl_nombre + "-" + h.acc_nombre] = h.modAcc_sliderShow
    end
  end
end
