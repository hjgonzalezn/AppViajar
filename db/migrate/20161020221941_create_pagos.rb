class CreatePagos < ActiveRecord::Migration[5.0]
  def change
    create_table :pagos do |t|
      t.string :pago_tipoProducto
      t.string :pago_productoId
      t.float :pago_valor
      t.string :pago_forma
      t.string :pago_ctaBancDestino
      t.date :pago_fecha
      t.string :pago_entidad
      t.integer :dtpag_sucursalId
      t.string :pago_transaccion
      t.string :pago_estado
      t.string :pago_estadoRegistro
      t.string :created_by
      t.string :updated_by

      t.timestamps null: false
    end
  end
end
