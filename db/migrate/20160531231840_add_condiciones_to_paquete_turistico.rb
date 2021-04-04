class AddCondicionesToPaqueteTuristico < ActiveRecord::Migration[5.0]
  def change
    add_column :paquete_turisticos, :pqTur_condiciones, :text
  end
end
