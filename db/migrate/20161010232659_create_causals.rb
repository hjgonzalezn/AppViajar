class CreateCausals < ActiveRecord::Migration[5.0]
  def change
    create_table :causals do |t|
      t.string :causal_tipo
      t.integer :causal_nivel
      t.string :causal_descripcion
      t.text :causal_solucion
      t.string :causal_estadoRegistro

      t.timestamps null: false
    end
  end
end
