class CreateCatalogos < ActiveRecord::Migration[5.0]
  def change
    create_table :catalogos do |t|
      t.string :ctlg_categoria
      t.string :ctlg_subcategoria
      t.string :ctlg_valorCdg
      t.string :ctlg_valorDesc
      t.string :ctlg_observacion
      t.string :ctlg_estadoRegistro

      t.timestamps null: false
    end
  end
end
