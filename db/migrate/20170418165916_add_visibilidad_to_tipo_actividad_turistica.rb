class AddVisibilidadToTipoActividadTuristica < ActiveRecord::Migration[5.0]
  def change
    add_column :tipo_actividad_turisticas, :tiAcT_visibilidad, :string
  end
end
