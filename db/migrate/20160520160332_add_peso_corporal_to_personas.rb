class AddPesoCorporalToPersonas < ActiveRecord::Migration
  def change
    add_column :personas, :pers_pesoCorporal, :integer
  end
end
