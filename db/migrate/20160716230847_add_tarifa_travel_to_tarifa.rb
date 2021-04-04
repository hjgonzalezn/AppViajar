class AddTarifaTravelToTarifa < ActiveRecord::Migration[5.0]
  def change
    add_column :tarifas, :trf_deluxe, :float
  end
end
