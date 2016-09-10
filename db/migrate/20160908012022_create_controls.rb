class CreateControls < ActiveRecord::Migration
  def change
    create_table :controls do |t|
      t.string :ctrl_descripcion
      t.string :ctrl_html_id
      t.string :ctrl_tipo
      t.references :modelo, index: true, foreign_key: true
      t.references :accion, index: true, foreign_key: true
      t.string :ctrl_created_by
      t.string :ctrl_updated_by
      t.string :ctrl_estadoRegistro

      t.timestamps null: false
    end
  end
end
