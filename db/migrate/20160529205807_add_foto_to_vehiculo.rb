class AddFotoToVehiculo < ActiveRecord::Migration[5.0]
  def change
    add_column :vehiculos, :vehi_foto, :string
  end
end
