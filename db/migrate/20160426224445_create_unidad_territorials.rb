class CreateUnidadTerritorials < ActiveRecord::Migration
  def change
    create_table :unidad_territorials do |t|
      t.string :undter_nombre
      t.string :undter_estadoRegistro

      t.timestamps null: false
    end
  end
end
