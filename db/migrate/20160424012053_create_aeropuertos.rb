class CreateAeropuertos < ActiveRecord::Migration
  def change
    create_table :aeropuertos do |t|
      t.string :aeropt_nombre
      t.string :aeropt_codigoIATA
      t.string :aeropt_ciudadCdg
      t.string :aeropt_estadoRegistro

      t.timestamps null: false
    end
  end
end
