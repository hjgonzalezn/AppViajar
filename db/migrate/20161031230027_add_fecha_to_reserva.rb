class AddFechaToReserva < ActiveRecord::Migration[5.0]
  def change
    add_column :reservas, :rsrv_fechaIda, :date
    add_column :reservas, :rsrv_fechaRegreso, :date
  end
end
