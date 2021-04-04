class AddCorreoElectronicoToEmpresa < ActiveRecord::Migration[5.0]
  def change
    add_column :empresas, :empr_correoElectronico, :string
  end
end
