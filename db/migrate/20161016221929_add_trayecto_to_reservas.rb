class AddTrayectoToReservas < ActiveRecord::Migration[5.0]
  def change
    add_column :reservas, :rsrv_trayectoViaje, :string
  end
end
