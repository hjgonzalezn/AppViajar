class AddNombreSucursalToSucursalEmpresa < ActiveRecord::Migration
  def change
    add_column :sucursal_empresas, :sucEmpr_nombreSucursal, :string
  end
end
