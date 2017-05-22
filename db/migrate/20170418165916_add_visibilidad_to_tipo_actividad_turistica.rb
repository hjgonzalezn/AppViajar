class AddVisibilidadToTipoActividadTuristica < ActiveRecord::Migration
  def change
    add_column :tipo_actividad_turisticas, :tiAcT_visibilidad, :string
  end
end
