class AddTituloToItinerario < ActiveRecord::Migration[5.0]
  def change
    add_column :itinerarios, :itnr_titulo, :string
  end
end
