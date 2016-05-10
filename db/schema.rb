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

ActiveRecord::Schema.define(version: 20160507005750) do

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
  end

  create_table "regions", force: :cascade do |t|
    t.string   "reg_nombre",                 limit: 255
    t.text     "reg_presentacion",           limit: 65535
    t.integer  "reg_entidad_territorial_id", limit: 4
    t.string   "reg_estadoRegistro",         limit: 255
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  create_table "unidad_territorials", force: :cascade do |t|
    t.string   "undter_nombre",         limit: 255
    t.string   "undter_estadoRegistro", limit: 255
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

end
