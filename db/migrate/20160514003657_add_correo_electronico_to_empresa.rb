class AddCorreoElectronicoToEmpresa < ActiveRecord::Migration
  def change
    add_column :empresas, :empr_correoElectronico, :string
  end
end
