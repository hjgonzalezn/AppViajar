class CreateReservas < ActiveRecord::Migration[5.0]
  def change
    create_table :reservas do |t|
      t.string :rsrv_codigo
      t.string :rsrv_tipoProducto
      t.integer :rsrv_productoId
      t.string :rsrv_tipoSolicitante
      t.string :rsrv_solicitanteId
      t.string :rsrv_tipoContacto
      t.string :rsrv_contactoId
      t.string :rsrv_estadoReserva
      t.string :rsrv_estadoRegistro
      t.datetime :rsrv_fechaVencimiento
      t.string :created_by
      t.string :updated_by

      t.timestamps null: false
    end
  end
end
