class AddNombreCortoToEmpresa < ActiveRecord::Migration[5.0]
  def change
    add_column :empresas, :empr_nombreCorto, :string
  end
end
