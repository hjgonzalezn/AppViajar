class AddCodigoIsotoEntidadTerritorials < ActiveRecord::Migration
  def change
    add_column :entidad_territorials, :enter_codigoISO, :string
    add_column :entidad_territorials, :enter_nombreCorto, :string
  end
end
