class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  def initialize_vars_global
    @estados = Hash.new
    Catalogo.where("ctlg_categoria = ? AND ctlg_estadoRegistro = ? ", "ESTADO DE REGISTRO", "A").find_each do |estado|
      @estados[estado.ctlg_valorCdg] = estado.ctlg_valorDesc 
    end
  end  
end
