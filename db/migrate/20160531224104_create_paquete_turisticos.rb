class CreatePaqueteTuristicos < ActiveRecord::Migration
  def change
    create_table :paquete_turisticos do |t|
      t.string :pqTur_nombre
      t.string :pqTur_descripcion
      t.text :pqTur_incluye
      t.text :pqTur_noIncluye
      t.text :pqTur_opcionales
      t.text :pqTur_recomendaciones
      t.date :pqTur_fechaVigenciaIni
      t.date :pqTur_fechaVigenciaFin
      t.date :pqTur_fechaPromocionIni
      t.date :pqTur_fechaPromocionFin
      t.string :pqTur_estadoRegistro

      t.timestamps null: false
    end
  end
end
