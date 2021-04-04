class AddPrioridadToRuta < ActiveRecord::Migration[5.0]
  def change
    add_column :ruta, :ruta_prioridad, :integer
  end
end
