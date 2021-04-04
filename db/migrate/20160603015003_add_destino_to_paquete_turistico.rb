class AddDestinoToPaqueteTuristico < ActiveRecord::Migration[5.0]
  def change
    add_column :paquete_turisticos, :pqTur_tipoDestino, :string
    add_column :paquete_turisticos, :pqTur_destino, :integer
    add_column :paquete_turisticos, :pqTur_portada, :string
  end
end
