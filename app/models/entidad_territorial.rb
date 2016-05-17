class EntidadTerritorial < ActiveRecord::Base
   has_many :division_pai, dependent: :destroy
   has_many :aeropuertos, dependent: :destroy
end
