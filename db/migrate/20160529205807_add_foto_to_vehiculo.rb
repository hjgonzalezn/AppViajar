class AddFotoToVehiculo < ActiveRecord::Migration
  def change
    add_column :vehiculos, :vehi_foto, :string
  end
end
