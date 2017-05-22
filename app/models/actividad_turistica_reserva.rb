class ActividadTuristicaReserva < ActiveRecord::Base
  belongs_to :actividad_turistica
  belongs_to :reserva
end
