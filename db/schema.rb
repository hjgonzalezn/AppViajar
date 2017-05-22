# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20170516232144) do

  create_table "abouts", force: :cascade do |t|
    t.string   "about_codigo",         limit: 255
    t.string   "about_titulo",         limit: 255
    t.text     "about_contenido",      limit: 65535
    t.string   "about_estadoRegistro", limit: 255
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  create_table "accions", force: :cascade do |t|
    t.string   "acc_codigo",         limit: 255
    t.string   "acc_nombre",         limit: 255
    t.string   "acc_estadoRegistro", limit: 255
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "actividad_turistica_plans", force: :cascade do |t|
    t.integer  "paquete_turistico_id",   limit: 4
    t.integer  "actividad_turistica_id", limit: 4
    t.string   "atp_clasificacion",      limit: 255
    t.string   "atp_estadoRegistro",     limit: 255
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  add_index "actividad_turistica_plans", ["actividad_turistica_id"], name: "index_actividad_turistica_plans_on_actividad_turistica_id", using: :btree
  add_index "actividad_turistica_plans", ["paquete_turistico_id"], name: "index_actividad_turistica_plans_on_paquete_turistico_id", using: :btree

  create_table "actividad_turistica_reservas", force: :cascade do |t|
    t.integer  "actividad_turistica_id", limit: 4
    t.integer  "reserva_id",             limit: 4
    t.string   "atr_estadoRegistro",     limit: 255
    t.string   "created_by",             limit: 255
    t.string   "updated_by",             limit: 255
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  add_index "actividad_turistica_reservas", ["actividad_turistica_id"], name: "index_actividad_turistica_reservas_on_actividad_turistica_id", using: :btree
  add_index "actividad_turistica_reservas", ["reserva_id"], name: "index_actividad_turistica_reservas_on_reserva_id", using: :btree

  create_table "actividad_turisticas", force: :cascade do |t|
    t.string   "actur_descripcion",           limit: 255
    t.integer  "tipo_actividad_turistica_id", limit: 4
    t.string   "actur_estadoRegistro",        limit: 255
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
  end

  add_index "actividad_turisticas", ["tipo_actividad_turistica_id"], name: "index_actividad_turisticas_on_tipo_actividad_turistica_id", using: :btree

  create_table "aeropuertos", force: :cascade do |t|
    t.string   "aeropt_nombre",         limit: 255
    t.string   "aeropt_codigoIATA",     limit: 255
    t.string   "aeropt_ciudadCdg",      limit: 255
    t.string   "aeropt_estadoRegistro", limit: 255
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  create_table "catalogos", force: :cascade do |t|
    t.string   "ctlg_categoria",      limit: 255
    t.string   "ctlg_subcategoria",   limit: 255
    t.string   "ctlg_valorCdg",       limit: 255
    t.string   "ctlg_valorDesc",      limit: 255
    t.string   "ctlg_observacion",    limit: 255
    t.string   "ctlg_estadoRegistro", limit: 255
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  create_table "causals", force: :cascade do |t|
    t.string   "causal_tipo",           limit: 255
    t.integer  "causal_nivel",          limit: 4
    t.string   "causal_descripcion",    limit: 255
    t.text     "causal_solucion",       limit: 65535
    t.string   "causal_estadoRegistro", limit: 255
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  create_table "controls", force: :cascade do |t|
    t.string   "ctrl_descripcion",    limit: 255
    t.string   "ctrl_html_id",        limit: 255
    t.string   "ctrl_tipo",           limit: 255
    t.integer  "modelo_id",           limit: 4
    t.integer  "accion_id",           limit: 4
    t.string   "ctrl_created_by",     limit: 255
    t.string   "ctrl_updated_by",     limit: 255
    t.string   "ctrl_estadoRegistro", limit: 255
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  add_index "controls", ["accion_id"], name: "index_controls_on_accion_id", using: :btree
  add_index "controls", ["modelo_id"], name: "index_controls_on_modelo_id", using: :btree

  create_table "costos", force: :cascade do |t|
    t.string   "empr_documentoIdentidad",  limit: 255
    t.integer  "sucursalEmpresaId",        limit: 4
    t.string   "cost_servicio",            limit: 255
    t.string   "cost_descripcionServicio", limit: 255
    t.float    "cost_valor",               limit: 24
    t.date     "cost_fechaInicio"
    t.date     "cost_fechaFin"
    t.string   "cost_estadoRegistro",      limit: 255
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  create_table "detalle_reservas", force: :cascade do |t|
    t.integer  "reserva_id",             limit: 4
    t.string   "detRsrv_tipoCliente",    limit: 255
    t.string   "detRsrv_clienteId",      limit: 255
    t.string   "detRsrv_tarifaCodigo",   limit: 255
    t.float    "detRsrv_valor",          limit: 24
    t.string   "created_by",             limit: 255
    t.string   "updated_by",             limit: 255
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.string   "detRsrv_estadoReserva",  limit: 255
    t.string   "detRsrv_estadoRegistro", limit: 255
  end

  add_index "detalle_reservas", ["reserva_id"], name: "index_detalle_reservas_on_reserva_id", using: :btree

  create_table "division_pais", force: :cascade do |t|
    t.integer  "entidad_territorial_id", limit: 4
    t.integer  "unidad_territorial_id",  limit: 4
    t.integer  "divpais_nivel",          limit: 4
    t.string   "divpais_estadoRegistro", limit: 255
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  create_table "empresas", force: :cascade do |t|
    t.string   "empr_documentoIdentidad", limit: 255
    t.string   "empr_razonSocial",        limit: 255
    t.string   "empr_tipoEmpresa",        limit: 255
    t.string   "empr_sectorEconomico",    limit: 255
    t.string   "empr_docIdentReprLegal",  limit: 255
    t.string   "empr_sitioWeb",           limit: 255
    t.string   "empr_otrosDatos",         limit: 255
    t.string   "empr_estadoRegistro",     limit: 255
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "empr_nombreCorto",        limit: 255
    t.string   "empr_correoElectronico",  limit: 255
  end

  create_table "entidad_territorials", force: :cascade do |t|
    t.string   "enter_nombreOficial",  limit: 255
    t.text     "enter_presentacion",   limit: 65535
    t.integer  "enter_padreId",        limit: 4
    t.integer  "enter_nivel",          limit: 4
    t.integer  "region_id",            limit: 4
    t.integer  "division_pais_id",     limit: 4
    t.string   "enter_estadoRegistro", limit: 255
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.string   "enter_codigoOficial",  limit: 255
    t.string   "enter_codigoISO",      limit: 255
    t.string   "enter_nombreCorto",    limit: 255
  end

  create_table "fotos", force: :cascade do |t|
    t.string   "foto_nombreArchivo",  limit: 255
    t.string   "foto_ruta",           limit: 255
    t.string   "foto_titulo",         limit: 255
    t.string   "foto_descripcion",    limit: 255
    t.string   "foto_entidadCodigo",  limit: 255
    t.integer  "foto_entidad_id",     limit: 4
    t.string   "foto_portada",        limit: 255
    t.string   "foto_estadoRegistro", limit: 255
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  create_table "hotels", force: :cascade do |t|
    t.integer  "empresa_id",           limit: 4
    t.text     "hotel_datosGenerales", limit: 65535
    t.text     "hotel_presentacion",   limit: 65535
    t.text     "hotel_servicios",      limit: 65535
    t.text     "hotel_atractivos",     limit: 65535
    t.string   "hotel_estadoRegistro", limit: 255
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.string   "hotel_portada",        limit: 255
  end

  add_index "hotels", ["empresa_id"], name: "index_hotels_on_empresa_id", using: :btree

  create_table "itinerarios", force: :cascade do |t|
    t.integer  "paquete_turistico_id", limit: 4
    t.string   "itnr_estadoRegistro",  limit: 255
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.string   "itnr_userCreate",      limit: 255
    t.string   "itnr_userUpdate",      limit: 255
    t.text     "itnr_actividad",       limit: 65535
    t.string   "itnr_titulo",          limit: 255
  end

  add_index "itinerarios", ["paquete_turistico_id"], name: "index_itinerarios_on_paquete_turistico_id", using: :btree

  create_table "logs", force: :cascade do |t|
    t.string   "log_modeloDesc",      limit: 255
    t.integer  "log_modeloId",        limit: 4
    t.text     "log_valoresAntes",    limit: 65535
    t.text     "log_valoresDespues",  limit: 65535
    t.string   "log_ruta",            limit: 255
    t.string   "log_operacion",       limit: 255
    t.string   "log_resultOperacion", limit: 255
    t.string   "log_equipo",          limit: 255
    t.string   "created_by",          limit: 255
    t.string   "updated_by",          limit: 255
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  create_table "modelo_accions", force: :cascade do |t|
    t.integer  "modelo_id",             limit: 4
    t.integer  "accion_id",             limit: 4
    t.string   "modAcc_tipoAcceso",     limit: 255
    t.string   "modAcc_sliderShow",     limit: 255
    t.string   "modAcc_estadoRegistro", limit: 255
    t.string   "modAcc_created_by",     limit: 255
    t.string   "modAcc_updated_by",     limit: 255
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  add_index "modelo_accions", ["accion_id"], name: "index_modelo_accions_on_accion_id", using: :btree
  add_index "modelo_accions", ["modelo_id"], name: "index_modelo_accions_on_modelo_id", using: :btree

  create_table "modelos", force: :cascade do |t|
    t.string   "mdl_codigo",         limit: 255
    t.string   "mdl_nombre",         limit: 255
    t.string   "mdl_estadoRegistro", limit: 255
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "pagos", force: :cascade do |t|
    t.string   "pago_tipoProducto",   limit: 255
    t.float    "pago_valor",          limit: 24
    t.string   "pago_forma",          limit: 255
    t.integer  "pago_ctaBancDestino", limit: 4
    t.date     "pago_fecha"
    t.string   "pago_entidad",        limit: 255
    t.integer  "dtpag_sucursalId",    limit: 4
    t.string   "pago_transaccion",    limit: 255
    t.string   "pago_estado",         limit: 255
    t.string   "pago_estadoRegistro", limit: 255
    t.string   "created_by",          limit: 255
    t.string   "updated_by",          limit: 255
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "pago_productoId",     limit: 255
  end

  create_table "paq_turistico_ent_territorials", force: :cascade do |t|
    t.integer  "paquete_turistico_id",      limit: 4
    t.integer  "entidad_territorial_id",    limit: 4
    t.string   "pqTurEnTer_estadoRegistro", limit: 255
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  add_index "paq_turistico_ent_territorials", ["entidad_territorial_id"], name: "index_paq_turistico_ent_territorials_on_entidad_territorial_id", using: :btree
  add_index "paq_turistico_ent_territorials", ["paquete_turistico_id"], name: "index_paq_turistico_ent_territorials_on_paquete_turistico_id", using: :btree

  create_table "paquete_turisticos", force: :cascade do |t|
    t.string   "pqTur_nombre",            limit: 255
    t.string   "pqTur_descripcion",       limit: 255
    t.text     "pqTur_incluye",           limit: 65535
    t.text     "pqTur_noIncluye",         limit: 65535
    t.text     "pqTur_opcionales",        limit: 65535
    t.text     "pqTur_recomendaciones",   limit: 65535
    t.date     "pqTur_fechaVigenciaIni"
    t.date     "pqTur_fechaVigenciaFin"
    t.date     "pqTur_fechaPromocionIni"
    t.date     "pqTur_fechaPromocionFin"
    t.string   "pqTur_estadoRegistro",    limit: 255
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.text     "pqTur_condiciones",       limit: 65535
    t.integer  "pqTur_duracion",          limit: 4
    t.string   "pqTur_tipoDestino",       limit: 255
    t.integer  "pqTur_destino",           limit: 4
    t.string   "pqTur_portada",           limit: 255
    t.string   "pqTur_programacion",      limit: 255
    t.integer  "pqTur_reservaMin",        limit: 4
    t.integer  "pqTur_reservaMax",        limit: 4
  end

  create_table "personas", force: :cascade do |t|
    t.string   "pers_documentoIdentidad",   limit: 255
    t.string   "pers_alias",                limit: 255
    t.string   "pers_sexo",                 limit: 255
    t.date     "pers_fechaNacimiento"
    t.string   "pers_estadoCivil",          limit: 255
    t.string   "pers_direccionDomicilio",   limit: 255
    t.integer  "pers_ciudadDomicilio",      limit: 4
    t.string   "pers_telefonoPersonal1",    limit: 255
    t.string   "pers_telefonoPersonal2",    limit: 255
    t.string   "pers_correoElectrPersonal", limit: 255
    t.string   "pers_correoElectrLaboral",  limit: 255
    t.string   "pers_perfilLaboral",        limit: 255
    t.integer  "sucursalEmpresaId",         limit: 4
    t.string   "empresaCargo",              limit: 255
    t.string   "pers_telefonoLaboral1",     limit: 255
    t.string   "pers_telefonoLaboral2",     limit: 255
    t.string   "pers_estadoRegistro",       limit: 255
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.string   "pers_apellidos",            limit: 255
    t.string   "pers_nombres",              limit: 255
    t.integer  "pers_paisOrigen",           limit: 4
    t.integer  "pers_pesoCorporal",         limit: 4
  end

  add_index "personas", ["pers_paisOrigen"], name: "fk_rails_ef4b3c4b9d", using: :btree

  create_table "regions", force: :cascade do |t|
    t.string   "reg_nombre",                 limit: 255
    t.text     "reg_presentacion",           limit: 65535
    t.integer  "reg_entidad_territorial_id", limit: 4
    t.string   "reg_estadoRegistro",         limit: 255
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  create_table "reservas", force: :cascade do |t|
    t.string   "rsrv_codigo",           limit: 255
    t.string   "rsrv_tipoProducto",     limit: 255
    t.integer  "rsrv_productoId",       limit: 4
    t.string   "rsrv_tipoSolicitante",  limit: 255
    t.string   "rsrv_solicitanteId",    limit: 255
    t.string   "rsrv_tipoContacto",     limit: 255
    t.string   "rsrv_contactoId",       limit: 255
    t.datetime "rsrv_fechaVencimiento"
    t.string   "created_by",            limit: 255
    t.string   "updated_by",            limit: 255
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "rsrv_estadoRegistro",   limit: 255
    t.string   "rsrv_estadoReserva",    limit: 255
    t.string   "rsrv_trayectoViaje",    limit: 255
    t.date     "rsrv_fechaIda"
    t.date     "rsrv_fechaRegreso"
    t.float    "rsrv_valorTotal",       limit: 24
  end

  create_table "ruta", force: :cascade do |t|
    t.string   "ruta_medio",          limit: 255
    t.string   "ruta_descripcion",    limit: 255
    t.string   "ruta_frecuencia",     limit: 255
    t.string   "ruta_vehiculo",       limit: 255
    t.string   "ruta_estadoRegistro", limit: 255
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.integer  "ruta_prioridad",      limit: 4
  end

  create_table "salidas", force: :cascade do |t|
    t.integer  "paquete_turistico_id", limit: 4
    t.date     "sld_fecha"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.string   "sld_estadoRegistro",   limit: 255
    t.string   "created_by",           limit: 255
    t.string   "updated_by",           limit: 255
  end

  add_index "salidas", ["paquete_turistico_id"], name: "index_salidas_on_paquete_turistico_id", using: :btree

  create_table "sucursal_empresas", force: :cascade do |t|
    t.string   "empr_documentoIdentidad",   limit: 255
    t.integer  "sucEmpr_ciudadDomicilio",   limit: 4
    t.string   "sucEmpr_direccion",         limit: 255
    t.string   "sucEmpr_telefono1",         limit: 255
    t.string   "sucEmpr_telefono2",         limit: 255
    t.string   "sucEmpr_correoElectronico", limit: 255
    t.string   "sucEmpr_docIdentContacto1", limit: 255
    t.string   "sucEmpr_docIdentContacto2", limit: 255
    t.string   "sucEmpr_TipoSucursal",      limit: 255
    t.string   "sucEmpr_horarioAtencion",   limit: 255
    t.string   "sucEmp_estadoRegistro",     limit: 255
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.string   "sucEmpr_nombreSucursal",    limit: 255
  end

  create_table "tarifas", force: :cascade do |t|
    t.string   "trf_concepto",           limit: 255
    t.string   "trf_conceptoCodigo",     limit: 255
    t.string   "trf_conceptoAplicacion", limit: 255
    t.string   "trf_detalleAplicacion",  limit: 255
    t.string   "trf_naturaleza",         limit: 255
    t.string   "trf_tipoProducto",       limit: 255
    t.string   "trf_producto",           limit: 255
    t.float    "trf_promo",              limit: 24
    t.float    "trf_econo",              limit: 24
    t.float    "trf_base",               limit: 24
    t.float    "trf_flexi",              limit: 24
    t.string   "trf_unidadCobro",        limit: 255
    t.date     "trf_fechaInicio"
    t.date     "trf_fechaFin"
    t.string   "trf_estadoRegistro",     limit: 255
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.float    "trf_deluxe",             limit: 24
  end

  create_table "tipo_actividad_turisticas", force: :cascade do |t|
    t.string   "tiAcT_nombre",         limit: 255
    t.string   "tiAcT_descripcion",    limit: 255
    t.string   "tiAcT_foto",           limit: 255
    t.string   "tiAcT_icono",          limit: 255
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.string   "tiAcT_estadoRegistro", limit: 255
    t.string   "tiAcT_visibilidad",    limit: 255
  end

  create_table "unidad_territorials", force: :cascade do |t|
    t.string   "undter_nombre",         limit: 255
    t.string   "undter_estadoRegistro", limit: 255
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  create_table "vehiculos", force: :cascade do |t|
    t.string   "vehi_tipo",                  limit: 255
    t.string   "vehi_modeloCodigo",          limit: 255
    t.string   "vehi_medioCodigo",           limit: 255
    t.string   "vehi_nombre",                limit: 255
    t.string   "vehi_matricula",             limit: 255
    t.string   "vehi_tipoPropietario",       limit: 255
    t.integer  "vehi_sucursalEmpresaPropId", limit: 4
    t.float    "vehi_capacPesoMaximo",       limit: 24
    t.float    "vehi_capacPesoPasajeros",    limit: 24
    t.float    "vehi_capacCargaBodega",      limit: 24
    t.integer  "vehi_capacPasajeros",        limit: 4
    t.string   "vehi_estadoRegistro",        limit: 255
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "vehi_propietarioId",         limit: 255
    t.string   "vehi_foto",                  limit: 255
  end

  create_table "viajes", force: :cascade do |t|
    t.string   "viaje_ruta",           limit: 255
    t.date     "viaje_fecha"
    t.string   "viaje_horaSalida",     limit: 255
    t.string   "viaje_estado",         limit: 255
    t.integer  "vehiculo_id",          limit: 4
    t.string   "viaje_estadoRegistro", limit: 255
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.string   "viaje_operadorId",     limit: 255
    t.string   "viaje_trayecto",       limit: 255
    t.string   "viaje_tarifas",        limit: 255
  end

  add_index "viajes", ["vehiculo_id"], name: "index_viajes_on_vehiculo_id", using: :btree

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
