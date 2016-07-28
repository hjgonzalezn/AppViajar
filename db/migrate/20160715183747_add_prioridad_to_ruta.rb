class AddPrioridadToRuta < ActiveRecord::Migration
  def change
    add_column :ruta, :ruta_prioridad, :integer
  end
end
