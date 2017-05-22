class CreateSalidas < ActiveRecord::Migration
  def change
    create_table :salidas do |t|
      t.references :paquete_turistico, index: true, foreign_key: true
      t.date :sld_fecha

      t.timestamps null: false
    end
  end
end
