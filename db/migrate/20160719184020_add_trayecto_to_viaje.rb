class AddTrayectoToViaje < ActiveRecord::Migration
  def change
    add_column :viajes, :viaje_trayecto, :string
  end
end
