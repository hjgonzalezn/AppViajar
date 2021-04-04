class CreateSucursalEmpresas < ActiveRecord::Migration[5.0]
  def change
    create_table :sucursal_empresas do |t|
      t.string :empr_documentoIdentidad
      t.integer :sucEmpr_ciudadDomicilio
      t.string :sucEmpr_direccion
      t.string :sucEmpr_telefono1
      t.string :sucEmpr_telefono2
      t.string :sucEmpr_correoElectronico
      t.string :sucEmpr_docIdentContacto1
      t.string :sucEmpr_docIdentContacto2
      t.string :sucEmpr_TipoSucursal
      t.string :sucEmpr_horarioAtencion
      t.string :sucEmp_estadoRegistro

      t.timestamps null: false
    end
  end
end
