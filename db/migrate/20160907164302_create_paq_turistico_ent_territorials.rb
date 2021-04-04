class CreatePaqTuristicoEntTerritorials < ActiveRecord::Migration[5.0]
  def change
    create_table :paq_turistico_ent_territorials do |t|
      t.references :paquete_turistico, index: true, foreign_key: true
      t.references :entidad_territorial, index: true, foreign_key: true
      t.string :pqTurEnTer_estadoRegistro

      t.timestamps null: false
    end
  end
end
