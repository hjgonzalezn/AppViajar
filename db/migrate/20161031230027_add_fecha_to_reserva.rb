class AddFechaToReserva < ActiveRecord::Migration
  def change
    add_column :reservas, :rsrv_fechaIda, :date
    add_column :reservas, :rsrv_fechaRegreso, :date
  end
end
