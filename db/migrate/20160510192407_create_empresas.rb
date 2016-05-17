class CreateEmpresas < ActiveRecord::Migration
  def change
    create_table :empresas do |t|
      t.string :empr_documentoIdentidad
      t.string :empr_razonSocial
      t.string :empr_tipoEmpresa
      t.string :empr_sectorEconomico
      t.string :empr_docIdentReprLegal
      t.string :empr_sitioWeb
      t.string :empr_otrosDatos
      t.string :empr_estadoRegistro

      t.timestamps null: false
    end
  end
end
