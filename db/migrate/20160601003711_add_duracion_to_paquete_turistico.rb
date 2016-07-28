class AddDuracionToPaqueteTuristico < ActiveRecord::Migration
  def change
    add_column :paquete_turisticos, :pqTur_duracion, :integer
  end
end
