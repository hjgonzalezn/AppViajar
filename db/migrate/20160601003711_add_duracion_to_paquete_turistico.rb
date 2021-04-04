class AddDuracionToPaqueteTuristico < ActiveRecord::Migration[5.0]
  def change
    add_column :paquete_turisticos, :pqTur_duracion, :integer
  end
end
