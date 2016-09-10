class CreateFotos < ActiveRecord::Migration
  def change
    create_table :fotos do |t|
      t.string :foto_nombreArchivo
      t.string :foto_ruta
      t.string :foto_titulo
      t.string :foto_descripcion
      t.string :foto_entidadCodigo
      t.integer :foto_entidad_id
      t.string :foto_portada
      t.string :foto_estadoRegistro

      t.timestamps null: false
    end
  end
end
