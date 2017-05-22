class AddProgramacionToPaqueteTuristico < ActiveRecord::Migration
  def change
    add_column :paquete_turisticos, :pqTur_programacion, :string
    add_column :paquete_turisticos, :pqTur_reservaMin, :integer
    add_column :paquete_turisticos, :pqTur_reservaMax, :integer
  end
end
