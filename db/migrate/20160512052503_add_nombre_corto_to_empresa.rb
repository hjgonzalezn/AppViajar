class AddNombreCortoToEmpresa < ActiveRecord::Migration
  def change
    add_column :empresas, :empr_nombreCorto, :string
  end
end
