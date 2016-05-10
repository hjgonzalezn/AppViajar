class CreateRegions < ActiveRecord::Migration
  def change
    create_table :regions do |t|
      t.string :reg_nombre
      t.text :reg_presentacion
      t.integer :reg_entidad_territorial_id
      t.string :reg_estadoRegistro

      t.timestamps null: false
    end
  end
end
