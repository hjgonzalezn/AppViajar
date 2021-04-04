class AddValorToReserva < ActiveRecord::Migration[5.0]
  def change
    add_column :reservas, :rsrv_valorTotal, :float
  end
end
