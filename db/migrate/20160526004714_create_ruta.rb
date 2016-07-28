class CreateRuta < ActiveRecord::Migration
  def change
    create_table :ruta do |t|
      t.string :ruta_medio
      t.string :ruta_descripcion
      t.string :ruta_frecuencia
      t.string :ruta_vehiculo
      t.string :ruta_estadoRegistro

      t.timestamps null: false
    end
  end
end
