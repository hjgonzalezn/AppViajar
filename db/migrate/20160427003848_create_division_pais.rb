class CreateDivisionPais < ActiveRecord::Migration[5.0]
  def change
    create_table :division_pais do |t|
      t.integer :entidad_territorial_id
      t.integer :unidad_territorial_id
      t.integer :divpais_nivel
      t.string :divpais_estadoRegistro

      t.timestamps null: false
    end
  end
end
