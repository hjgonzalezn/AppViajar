class AddCodigoIsotoEntidadTerritorials < ActiveRecord::Migration[5.0]
  def change
    add_column :entidad_territorials, :enter_codigoISO, :string
    add_column :entidad_territorials, :enter_nombreCorto, :string
  end
end
