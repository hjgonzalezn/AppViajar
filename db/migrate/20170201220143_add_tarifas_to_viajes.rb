class AddTarifasToViajes < ActiveRecord::Migration[5.0]
  def change
    add_column :viajes, :viaje_tarifas, :string
  end
end
