class CreateEntidadTerritorials < ActiveRecord::Migration
  def change
    create_table :entidad_territorials do |t|
      t.string :enter_nombreOficial
      t.text :enter_presentacion
      t.integer :enter_padreId
      t.integer :enter_nivel
      t.integer :region_id
      t.integer :division_pais_id
      t.string :enter_estadoRegistro

      t.timestamps null: false
    end
  end
end
