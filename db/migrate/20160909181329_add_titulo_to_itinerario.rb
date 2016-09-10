class AddTituloToItinerario < ActiveRecord::Migration
  def change
    add_column :itinerarios, :itnr_titulo, :string
  end
end
