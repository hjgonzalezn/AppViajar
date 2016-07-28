class CreateViajes < ActiveRecord::Migration
  def change
    create_table :viajes do |t|
      t.string :viaje_ruta
      t.date :viaje_fecha
      t.string :viaje_horaSalida
      t.string :viaje_estado
      t.references :vehiculo, index: true, foreign_key: true
      t.string :viaje_estadoRegistro

      t.timestamps null: false
    end
  end
end
