class AddEstadoRegistroToTipoActividadTuristica < ActiveRecord::Migration[5.0]
  def change
    add_column :tipo_actividad_turisticas, :tiAcT_estadoRegistro, :string
  end
end
