class ActividadTuristicaPlan < ActiveRecord::Base
  belongs_to :paquete_turistico
  belongs_to :actividad_turistica
  validates :paquete_turistico, uniqueness: {scope: :actividad_turistica_id,  }
end
