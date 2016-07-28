class AddOperadorToViaje < ActiveRecord::Migration
  def change
    add_column :viajes, :viaje_operadorId, :string
  end
end
