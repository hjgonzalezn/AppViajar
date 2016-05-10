class EntidadTerritorial < ActiveRecord::Base
   has_many :division_pai, dependent: :destroy
end
