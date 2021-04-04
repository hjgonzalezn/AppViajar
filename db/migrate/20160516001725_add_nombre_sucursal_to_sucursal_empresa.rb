class AddNombreSucursalToSucursalEmpresa < ActiveRecord::Migration[5.0]
  def change
    add_column :sucursal_empresas, :sucEmpr_nombreSucursal, :string
  end
end
