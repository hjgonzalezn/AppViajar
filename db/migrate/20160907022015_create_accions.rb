class CreateAccions < ActiveRecord::Migration
  def change
    create_table :accions do |t|
      t.string :acc_codigo
      t.string :acc_nombre
      t.string :acc_estadoRegistro

      t.timestamps null: false
    end
  end
end
