class CreateVehiculos < ActiveRecord::Migration[5.0]
  def change
    create_table :vehiculos do |t|
      t.string :vehi_tipo
      t.string :vehi_modeloCodigo
      t.string :vehi_medioCodigo
      t.string :vehi_nombre
      t.string :vehi_matricula
      t.string :vehi_propietarioId
      t.string :vehi_tipoPropietario
      t.integer :vehi_sucursalEmpresaPropId
      t.float :vehi_capacPesoMaximo
      t.float :vehi_capacPesoPasajeros
      t.float :vehi_capacCargaBodega
      t.integer :vehi_capacPasajeros
      t.string :vehi_estadoRegistro

      t.timestamps null: false
    end
  end
end
