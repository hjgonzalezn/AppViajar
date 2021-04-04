class CreateTipoActividadTuristicas < ActiveRecord::Migration[5.0]
  def change
    create_table :tipo_actividad_turisticas do |t|
      t.string :tiAcT_nombre
      t.string :tiAcT_descripcion
      t.string :tiAcT_foto
      t.string :tiAcT_icono

      t.timestamps null: false
    end
  end
end
