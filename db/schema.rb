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

ActiveRecord::Schema.define(version: 20160518225117) do

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
    t.integer  "entidad_territorials_id",   limit: 4
    t.string   "pers_apellidos",            limit: 255
    t.string   "pers_nombres",              limit: 255
    t.integer  "pers_paisOrigen",           limit: 4
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
    t.integer  "vehi_propietarioId",         limit: 4
    t.string   "vehi_tipoPropietario",       limit: 255
    t.integer  "vehi_sucursalEmpresaPropId", limit: 4
    t.float    "vehi_capacPesoMaximo",       limit: 24
    t.float    "vehi_capacPesoPasajeros",    limit: 24
    t.float    "vehi_capacCargaBodega",      limit: 24
    t.integer  "vehi_capacPasajeros",        limit: 4
    t.string   "vehi_estadoRegistro",        limit: 255
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  add_foreign_key "personas", "entidad_territorials", column: "pers_paisOrigen"
end
