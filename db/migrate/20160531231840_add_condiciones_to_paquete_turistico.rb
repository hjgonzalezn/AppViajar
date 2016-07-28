class AddCondicionesToPaqueteTuristico < ActiveRecord::Migration
  def change
    add_column :paquete_turisticos, :pqTur_condiciones, :text
  end
end
