class AddPortadaToHotel < ActiveRecord::Migration
  def change
    add_column :hotels, :hotel_portada, :string
  end
end
