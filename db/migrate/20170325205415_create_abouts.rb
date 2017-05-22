class CreateAbouts < ActiveRecord::Migration
  def change
    create_table :abouts do |t|
      t.string :about_codigo
      t.string :about_titulo
      t.text :about_contenido
      t.string :about_estadoRegistro

      t.timestamps null: false
    end
  end
end
