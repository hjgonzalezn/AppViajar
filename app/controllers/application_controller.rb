class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  def initialize_vars_global
    @estados = Hash.new
    @tiposDocumIdent = Hash.new
    
    todoCatalogo = Catalogo.where("ctlg_estadoRegistro = ?", "A")
    
    todoCatalogo.each do |h|
      if h.ctlg_categoria == "ESTADO DE REGISTRO" then
        @estados[h.ctlg_valorCdg] = h.ctlg_valorDesc
      elsif h.ctlg_categoria == "TIPO DE DOCUMENTO DE IDENTIDAD" then
        # Tipos de documento de identidad
        @tiposDocumIdent[h.ctlg_valorCdg] = h.ctlg_valorDesc
      end
    end   
  end  
end
