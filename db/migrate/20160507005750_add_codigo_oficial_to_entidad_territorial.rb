class AddCodigoOficialToEntidadTerritorial < ActiveRecord::Migration
  def change
    add_column :entidad_territorials, :enter_codigoOficial, :string
  end
end
