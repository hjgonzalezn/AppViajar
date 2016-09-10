class CreateModeloAccions < ActiveRecord::Migration
  def change
    create_table :modelo_accions do |t|
      t.references :modelo, index: true, foreign_key: true
      t.references :accion, index: true, foreign_key: true
      t.string :modAcc_tipoAcceso
      t.string :modAcc_sliderShow
      t.string :modAcc_estadoRegistro
      t.string :modAcc_created_by
      t.string :modAcc_updated_by

      t.timestamps null: false
    end
  end
end
