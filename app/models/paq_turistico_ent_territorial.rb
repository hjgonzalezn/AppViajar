class PaqTuristicoEntTerritorial < ActiveRecord::Base
  belongs_to :paquete_turistico
  belongs_to :entidad_territorial
end
