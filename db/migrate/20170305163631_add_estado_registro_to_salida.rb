class AddEstadoRegistroToSalida < ActiveRecord::Migration
  def change
    add_column :salidas, :sld_estadoRegistro, :string
    add_column :salidas, :created_by, :string
    add_column :salidas, :updated_by, :string
  end
end
