class CreatePersonas < ActiveRecord::Migration
  def change
    create_table :personas do |t|
      t.string :pers_documentoIdentidad
      t.string :pers_nombreCompleto
      t.string :pers_alias
      t.string :pers_sexo
      t.date :pers_fechaNacimiento
      t.string :pers_estadoCivil
      t.string :pers_direccionDomicilio
      t.integer :pers_ciudadDomicilio
      t.string :pers_telefonoPersonal1
      t.string :pers_telefonoPersonal2
      t.string :pers_correoElectrPersonal
      t.string :pers_correoElectrLaboral
      t.string :pers_perfilLaboral
      t.integer :sucursalEmpresaId
      t.string :empresaCargo
      t.string :pers_telefonoLaboral1
      t.string :pers_telefonoLaboral2
      t.string :pers_estadoRegistro

      t.timestamps null: false
    end
  end
end
