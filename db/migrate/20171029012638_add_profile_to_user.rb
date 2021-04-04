class AddProfileToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :admin, :boolean
    add_column :users, :employee, :boolean
  end
end
