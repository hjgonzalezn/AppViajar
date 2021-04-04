class CreateLogs < ActiveRecord::Migration[5.0]
  def change
    create_table :logs do |t|
      t.string :log_modeloDesc
      t.integer :log_modeloId
      t.text :log_valoresAntes
      t.text :log_valoresDespues
      t.string :log_ruta
      t.string :log_operacion
      t.string :log_resultOperacion
      t.string :log_equipo
      t.string :created_by
      t.string :updated_by

      t.timestamps null: false
    end
  end
end
