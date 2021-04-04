class CreateTarifas < ActiveRecord::Migration[5.0]
  def change
    create_table :tarifas do |t|
      t.string :trf_concepto
      t.string :trf_conceptoCodigo
      t.string :trf_conceptoAplicacion
      t.string :trf_detalleAplicacion
      t.string :trf_naturaleza
      t.string :trf_tipoProducto
      t.string :trf_producto
      t.float :trf_promo
      t.float :trf_econo
      t.float :trf_base
      t.float :trf_flexi
      t.string :trf_unidadCobro
      t.date :trf_fechaInicio
      t.date :trf_fechaFin
      t.string :trf_estadoRegistro

      t.timestamps null: false
    end
  end
end
