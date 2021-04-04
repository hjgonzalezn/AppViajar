class CreateUnidadTerritorials < ActiveRecord::Migration[5.0]
  def change
    create_table :unidad_territorials do |t|
      t.string :undter_nombre
      t.string :undter_estadoRegistro

      t.timestamps null: false
    end
  end
end
