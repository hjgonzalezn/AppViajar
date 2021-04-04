class CreateDetalleReservas < ActiveRecord::Migration[5.0]
  def change
    create_table :detalle_reservas do |t|
      t.references :reserva, index: true, foreign_key: true
      t.string :detRsrv_tipoCliente
      t.string :detRsrv_clienteId
	    t.string :detRsrv_tarifaCodigo
	    t.float :detRsrv_valor
	    t.string :detRsrv_estadoReserva
	    t.string :detRsrv_estadoRegistro
      t.string :created_by
      t.string :updated_by
      t.timestamps null: false
    end
  end
end
