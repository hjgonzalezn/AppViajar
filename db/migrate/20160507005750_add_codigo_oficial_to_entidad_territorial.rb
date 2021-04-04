class AddCodigoOficialToEntidadTerritorial < ActiveRecord::Migration[5.0]
  def change
    add_column :entidad_territorials, :enter_codigoOficial, :string
  end
end
