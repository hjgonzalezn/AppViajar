class AddProfileToUser < ActiveRecord::Migration
  def change
    add_column :users, :admin, :boolean
    add_column :users, :employee, :boolean
  end
end
