class CreateHotels < ActiveRecord::Migration[5.0]
  def change
    create_table :hotels do |t|
      t.references :empresa, index: true, foreign_key: true
      t.text :hotel_datosGenerales
      t.text :hotel_presentacion
      t.text :hotel_servicios
      t.text :hotel_atractivos
      t.string :hotel_estadoRegistro

      t.timestamps null: false
    end
  end
end
