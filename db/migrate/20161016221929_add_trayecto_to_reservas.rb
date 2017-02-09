class AddTrayectoToReservas < ActiveRecord::Migration
  def change
    add_column :reservas, :rsrv_trayectoViaje, :string
  end
end
