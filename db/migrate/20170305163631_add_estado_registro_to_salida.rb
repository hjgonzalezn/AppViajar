class AddEstadoRegistroToSalida < ActiveRecord::Migration[5.0]
  def change
    add_column :salidas, :sld_estadoRegistro, :string
    add_column :salidas, :created_by, :string
    add_column :salidas, :updated_by, :string
  end
end
