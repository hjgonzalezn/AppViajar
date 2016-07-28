class AddEstadoRegistroToTipoActividadTuristica < ActiveRecord::Migration
  def change
    add_column :tipo_actividad_turisticas, :tiAcT_estadoRegistro, :string
  end
end
