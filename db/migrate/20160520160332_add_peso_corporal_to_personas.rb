class AddPesoCorporalToPersonas < ActiveRecord::Migration[5.0]
  def change
    add_column :personas, :pers_pesoCorporal, :integer
  end
end
