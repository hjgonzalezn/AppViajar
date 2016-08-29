class CreateItinerarios < ActiveRecord::Migration
  def change
    create_table :itinerarios do |t|
      t.references :paquete_turistico, index: true, foreign_key: true
      t.text :itnr_actividad
      t.string :itnr_estadoRegistro

      t.timestamps null: false
    end
  end
end
