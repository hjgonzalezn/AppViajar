class CreateActividadTuristicaPlans < ActiveRecord::Migration[5.0]
  def change
    create_table :actividad_turistica_plans do |t|
      t.references :paquete_turistico, index: true, foreign_key: true
      t.references :actividad_turistica, index: true, foreign_key: true
      t.string :atp_clasificacion
      t.string :atp_estadoRegistro

      t.timestamps null: false
    end
  end
end
