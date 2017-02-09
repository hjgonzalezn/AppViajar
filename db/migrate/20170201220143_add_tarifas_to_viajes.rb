class AddTarifasToViajes < ActiveRecord::Migration
  def change
    add_column :viajes, :viaje_tarifas, :string
  end
end
