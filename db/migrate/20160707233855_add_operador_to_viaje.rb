class AddOperadorToViaje < ActiveRecord::Migration[5.0]
  def change
    add_column :viajes, :viaje_operadorId, :string
  end
end
