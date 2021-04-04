class AddNacionalidadToPersonas < ActiveRecord::Migration[5.0]
  def change
    add_column :personas, :pers_apellidos, :string, index: true
    add_column :personas, :pers_nombres, :string, index: true
    add_column :personas, :pers_paisOrigen, :integer
    add_foreign_key :personas, :entidad_territorials, column: :pers_paisOrigen
  end
end
