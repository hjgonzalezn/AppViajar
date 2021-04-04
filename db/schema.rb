# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20171029012638) do

  create_table "abouts", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "about_codigo"
    t.string "about_titulo"
    t.text "about_contenido"
    t.string "about_estadoRegistro"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "accions", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "acc_codigo"
    t.string "acc_nombre"
    t.string "acc_estadoRegistro"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "actividad_turistica_plans", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "paquete_turistico_id"
    t.integer "actividad_turistica_id"
    t.string "atp_clasificacion"
    t.string "atp_estadoRegistro"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["actividad_turistica_id"], name: "index_actividad_turistica_plans_on_actividad_turistica_id"
    t.index ["paquete_turistico_id"], name: "index_actividad_turistica_plans_on_paquete_turistico_id"
  end

  create_table "actividad_turistica_reservas", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "actividad_turistica_id"
    t.integer "reserva_id"
    t.string "atr_estadoRegistro"
    t.string "created_by"
    t.string "updated_by"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["actividad_turistica_id"], name: "index_actividad_turistica_reservas_on_actividad_turistica_id"
    t.index ["reserva_id"], name: "index_actividad_turistica_reservas_on_reserva_id"
  end

  create_table "actividad_turisticas", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "actur_descripcion"
    t.integer "tipo_actividad_turistica_id"
    t.string "actur_estadoRegistro"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tipo_actividad_turistica_id"], name: "index_actividad_turisticas_on_tipo_actividad_turistica_id"
  end

  create_table "aeropuertos", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "aeropt_nombre"
    t.string "aeropt_codigoIATA"
    t.string "aeropt_ciudadCdg"
    t.string "aeropt_estadoRegistro"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "catalogos", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "ctlg_categoria"
    t.string "ctlg_subcategoria"
    t.string "ctlg_valorCdg"
    t.string "ctlg_valorDesc"
    t.string "ctlg_observacion"
    t.string "ctlg_estadoRegistro"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "causals", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "causal_tipo"
    t.integer "causal_nivel"
    t.string "causal_descripcion"
    t.text "causal_solucion"
    t.string "causal_estadoRegistro"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "controls", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "ctrl_descripcion"
    t.string "ctrl_html_id"
    t.string "ctrl_tipo"
    t.integer "modelo_id"
    t.integer "accion_id"
    t.string "ctrl_created_by"
    t.string "ctrl_updated_by"
    t.string "ctrl_estadoRegistro"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["accion_id"], name: "index_controls_on_accion_id"
    t.index ["modelo_id"], name: "index_controls_on_modelo_id"
  end

  create_table "detalle_reservas", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "reserva_id"
    t.string "detRsrv_tipoCliente"
    t.string "detRsrv_clienteId"
    t.string "detRsrv_tarifaCodigo"
    t.float "detRsrv_valor", limit: 24
    t.string "detRsrv_estadoReserva"
    t.string "detRsrv_estadoRegistro"
    t.string "created_by"
    t.string "updated_by"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["reserva_id"], name: "index_detalle_reservas_on_reserva_id"
  end

  create_table "division_pais", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "entidad_territorial_id"
    t.integer "unidad_territorial_id"
    t.integer "divpais_nivel"
    t.string "divpais_estadoRegistro"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "empresas", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "empr_documentoIdentidad"
    t.string "empr_razonSocial"
    t.string "empr_tipoEmpresa"
    t.string "empr_sectorEconomico"
    t.string "empr_docIdentReprLegal"
    t.string "empr_sitioWeb"
    t.string "empr_otrosDatos"
    t.string "empr_estadoRegistro"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "empr_nombreCorto"
    t.string "empr_correoElectronico"
  end

  create_table "entidad_territorials", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "enter_nombreOficial"
    t.text "enter_presentacion"
    t.integer "enter_padreId"
    t.integer "enter_nivel"
    t.integer "region_id"
    t.integer "division_pais_id"
    t.string "enter_estadoRegistro"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "enter_codigoOficial"
    t.string "enter_codigoISO"
    t.string "enter_nombreCorto"
  end

  create_table "fotos", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "foto_nombreArchivo"
    t.string "foto_ruta"
    t.string "foto_titulo"
    t.string "foto_descripcion"
    t.string "foto_entidadCodigo"
    t.integer "foto_entidad_id"
    t.string "foto_portada"
    t.string "foto_estadoRegistro"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "hotels", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "empresa_id"
    t.text "hotel_datosGenerales"
    t.text "hotel_presentacion"
    t.text "hotel_servicios"
    t.text "hotel_atractivos"
    t.string "hotel_estadoRegistro"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "hotel_portada"
    t.index ["empresa_id"], name: "index_hotels_on_empresa_id"
  end

  create_table "itinerarios", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "paquete_turistico_id"
    t.text "itnr_actividad"
    t.string "itnr_estadoRegistro"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "itnr_userCreate"
    t.string "itnr_userUpdate"
    t.string "itnr_titulo"
    t.index ["paquete_turistico_id"], name: "index_itinerarios_on_paquete_turistico_id"
  end

  create_table "logs", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "log_modeloDesc"
    t.integer "log_modeloId"
    t.text "log_valoresAntes"
    t.text "log_valoresDespues"
    t.string "log_ruta"
    t.string "log_operacion"
    t.string "log_resultOperacion"
    t.string "log_equipo"
    t.string "created_by"
    t.string "updated_by"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "modelo_accions", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "modelo_id"
    t.integer "accion_id"
    t.string "modAcc_tipoAcceso"
    t.string "modAcc_sliderShow"
    t.string "modAcc_estadoRegistro"
    t.string "modAcc_created_by"
    t.string "modAcc_updated_by"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["accion_id"], name: "index_modelo_accions_on_accion_id"
    t.index ["modelo_id"], name: "index_modelo_accions_on_modelo_id"
  end

  create_table "modelos", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "mdl_codigo"
    t.string "mdl_nombre"
    t.string "mdl_estadoRegistro"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pagos", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "pago_tipoProducto"
    t.string "pago_productoId"
    t.float "pago_valor", limit: 24
    t.string "pago_forma"
    t.string "pago_ctaBancDestino"
    t.date "pago_fecha"
    t.string "pago_entidad"
    t.integer "dtpag_sucursalId"
    t.string "pago_transaccion"
    t.string "pago_estado"
    t.string "pago_estadoRegistro"
    t.string "created_by"
    t.string "updated_by"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "paq_turistico_ent_territorials", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "paquete_turistico_id"
    t.integer "entidad_territorial_id"
    t.string "pqTurEnTer_estadoRegistro"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["entidad_territorial_id"], name: "index_paq_turistico_ent_territorials_on_entidad_territorial_id"
    t.index ["paquete_turistico_id"], name: "index_paq_turistico_ent_territorials_on_paquete_turistico_id"
  end

  create_table "paquete_turisticos", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "pqTur_nombre"
    t.string "pqTur_descripcion"
    t.text "pqTur_incluye"
    t.text "pqTur_noIncluye"
    t.text "pqTur_opcionales"
    t.text "pqTur_recomendaciones"
    t.date "pqTur_fechaVigenciaIni"
    t.date "pqTur_fechaVigenciaFin"
    t.date "pqTur_fechaPromocionIni"
    t.date "pqTur_fechaPromocionFin"
    t.string "pqTur_estadoRegistro"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "pqTur_condiciones"
    t.integer "pqTur_duracion"
    t.string "pqTur_tipoDestino"
    t.integer "pqTur_destino"
    t.string "pqTur_portada"
    t.string "pqTur_programacion"
    t.integer "pqTur_reservaMin"
    t.integer "pqTur_reservaMax"
  end

  create_table "personas", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "pers_documentoIdentidad"
    t.string "pers_nombreCompleto"
    t.string "pers_alias"
    t.string "pers_sexo"
    t.date "pers_fechaNacimiento"
    t.string "pers_estadoCivil"
    t.string "pers_direccionDomicilio"
    t.integer "pers_ciudadDomicilio"
    t.string "pers_telefonoPersonal1"
    t.string "pers_telefonoPersonal2"
    t.string "pers_correoElectrPersonal"
    t.string "pers_correoElectrLaboral"
    t.string "pers_perfilLaboral"
    t.integer "sucursalEmpresaId"
    t.string "empresaCargo"
    t.string "pers_telefonoLaboral1"
    t.string "pers_telefonoLaboral2"
    t.string "pers_estadoRegistro"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "pers_apellidos"
    t.string "pers_nombres"
    t.integer "pers_paisOrigen"
    t.integer "pers_pesoCorporal"
    t.index ["pers_paisOrigen"], name: "fk_rails_ef4b3c4b9d"
  end

  create_table "regions", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "reg_nombre"
    t.text "reg_presentacion"
    t.integer "reg_entidad_territorial_id"
    t.string "reg_estadoRegistro"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reservas", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "rsrv_codigo"
    t.string "rsrv_tipoProducto"
    t.integer "rsrv_productoId"
    t.string "rsrv_tipoSolicitante"
    t.string "rsrv_solicitanteId"
    t.string "rsrv_tipoContacto"
    t.string "rsrv_contactoId"
    t.string "rsrv_estadoReserva"
    t.string "rsrv_estadoRegistro"
    t.datetime "rsrv_fechaVencimiento"
    t.string "created_by"
    t.string "updated_by"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "rsrv_trayectoViaje"
    t.date "rsrv_fechaIda"
    t.date "rsrv_fechaRegreso"
    t.float "rsrv_valorTotal", limit: 24
  end

  create_table "ruta", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "ruta_medio"
    t.string "ruta_descripcion"
    t.string "ruta_frecuencia"
    t.string "ruta_vehiculo"
    t.string "ruta_estadoRegistro"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "ruta_prioridad"
  end

  create_table "salidas", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "paquete_turistico_id"
    t.date "sld_fecha"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "sld_estadoRegistro"
    t.string "created_by"
    t.string "updated_by"
    t.index ["paquete_turistico_id"], name: "index_salidas_on_paquete_turistico_id"
  end

  create_table "sucursal_empresas", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "empr_documentoIdentidad"
    t.integer "sucEmpr_ciudadDomicilio"
    t.string "sucEmpr_direccion"
    t.string "sucEmpr_telefono1"
    t.string "sucEmpr_telefono2"
    t.string "sucEmpr_correoElectronico"
    t.string "sucEmpr_docIdentContacto1"
    t.string "sucEmpr_docIdentContacto2"
    t.string "sucEmpr_TipoSucursal"
    t.string "sucEmpr_horarioAtencion"
    t.string "sucEmp_estadoRegistro"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "sucEmpr_nombreSucursal"
  end

  create_table "tarifas", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "trf_concepto"
    t.string "tfr_conceptoCodigo"
    t.string "trf_conceptoAplicacion"
    t.string "trf_detalleAplicacion"
    t.string "trf_naturaleza"
    t.string "trf_tipoProducto"
    t.string "trf_producto"
    t.float "trf_promo", limit: 24
    t.float "trf_econo", limit: 24
    t.float "trf_base", limit: 24
    t.float "trf_flexi", limit: 24
    t.string "trf_unidadCobro"
    t.date "trf_fechaInicio"
    t.date "trf_fechaFin"
    t.string "trf_estadoRegistro"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "trf_deluxe", limit: 24
  end

  create_table "tipo_actividad_turisticas", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "tiAcT_nombre"
    t.string "tiAcT_descripcion"
    t.string "tiAcT_foto"
    t.string "tiAcT_icono"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "tiAcT_estadoRegistro"
    t.string "tiAcT_visibilidad"
  end

  create_table "unidad_territorials", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "undter_nombre"
    t.string "undter_estadoRegistro"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin"
    t.boolean "employee"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "vehiculos", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "vehi_tipo"
    t.string "vehi_modeloCodigo"
    t.string "vehi_medioCodigo"
    t.string "vehi_nombre"
    t.string "vehi_matricula"
    t.string "vehi_propietarioId"
    t.string "vehi_tipoPropietario"
    t.integer "vehi_sucursalEmpresaPropId"
    t.float "vehi_capacPesoMaximo", limit: 24
    t.float "vehi_capacPesoPasajeros", limit: 24
    t.float "vehi_capacCargaBodega", limit: 24
    t.integer "vehi_capacPasajeros"
    t.string "vehi_estadoRegistro"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "vehi_foto"
  end

  create_table "viajes", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "viaje_ruta"
    t.date "viaje_fecha"
    t.string "viaje_horaSalida"
    t.string "viaje_estado"
    t.integer "vehiculo_id"
    t.string "viaje_estadoRegistro"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "viaje_operadorId"
    t.string "viaje_trayecto"
    t.string "viaje_tarifas"
    t.index ["vehiculo_id"], name: "index_viajes_on_vehiculo_id"
  end

  add_foreign_key "actividad_turistica_plans", "actividad_turisticas"
  add_foreign_key "actividad_turistica_plans", "paquete_turisticos"
  add_foreign_key "actividad_turistica_reservas", "actividad_turisticas"
  add_foreign_key "actividad_turistica_reservas", "reservas"
  add_foreign_key "actividad_turisticas", "tipo_actividad_turisticas"
  add_foreign_key "controls", "accions"
  add_foreign_key "controls", "modelos"
  add_foreign_key "detalle_reservas", "reservas"
  add_foreign_key "hotels", "empresas"
  add_foreign_key "itinerarios", "paquete_turisticos"
  add_foreign_key "modelo_accions", "accions"
  add_foreign_key "modelo_accions", "modelos"
  add_foreign_key "paq_turistico_ent_territorials", "entidad_territorials"
  add_foreign_key "paq_turistico_ent_territorials", "paquete_turisticos"
  add_foreign_key "personas", "entidad_territorials", column: "pers_paisOrigen"
  add_foreign_key "salidas", "paquete_turisticos"
  add_foreign_key "viajes", "vehiculos"
end
