class AddTarifaTravelToTarifa < ActiveRecord::Migration
  def change
    add_column :tarifas, :trf_deluxe, :float
  end
end
