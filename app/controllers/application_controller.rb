class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  def initialize_vars_global
    @meses = {1 => "Ene", 2 => "Feb", 3 => "Mar", 4 => "Abr", 5 => "May", 6 =>  "Jun", 7 => "Jul", 8 => "Ago", 9 => "Sep", 10 => "Oct", 11 => "Nov", 12 => "Dic" }
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
