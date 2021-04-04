class CreateActividadTuristicaReservas < ActiveRecord::Migration[5.0]
  def change
    create_table :actividad_turistica_reservas do |t|
      t.references :actividad_turistica, index: true, foreign_key: true
      t.references :reserva, index: true, foreign_key: true
      t.string :atr_estadoRegistro
      t.string :created_by
      t.string :updated_by

      t.timestamps null: false
    end
  end
end
