class Empresa < ActiveRecord::Base
  has_many :sucursal_empresas
  has_many :vehiculos
end
