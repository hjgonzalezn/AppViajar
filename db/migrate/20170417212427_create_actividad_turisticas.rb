class CreateActividadTuristicas < ActiveRecord::Migration
  def change
    create_table :actividad_turisticas do |t|
      t.string :actur_descripcion
      t.references :tipo_actividad_turistica, index: true, foreign_key: true
      t.string :actur_estadoRegistro

      t.timestamps null: false
    end
  end
end
