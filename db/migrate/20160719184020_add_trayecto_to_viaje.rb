class AddTrayectoToViaje < ActiveRecord::Migration[5.0]
  def change
    add_column :viajes, :viaje_trayecto, :string
  end
end
