class AddValorToReserva < ActiveRecord::Migration
  def change
    add_column :reservas, :rsrv_valorTotal, :float
  end
end
