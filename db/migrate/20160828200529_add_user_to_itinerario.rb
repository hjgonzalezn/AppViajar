class AddUserToItinerario < ActiveRecord::Migration[5.0]
  def change
    add_column :itinerarios, :itnr_userCreate, :string
    add_column :itinerarios, :itnr_userUpdate, :string
  end
end
