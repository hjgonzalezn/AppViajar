class AddPortadaToHotel < ActiveRecord::Migration[5.0]
  def change
    add_column :hotels, :hotel_portada, :string
  end
end
