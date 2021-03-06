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

ActiveRecord::Schema.define(version: 20190122184215) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "nome"
    t.integer  "privilegio"
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree

  create_table "calculations", force: :cascade do |t|
    t.float    "salario_minimo"
    t.float    "fgts"
    t.float    "inss"
    t.float    "seguro_aci_trabalho"
    t.float    "sebrae"
    t.float    "incra"
    t.float    "salario_educacao"
    t.float    "sesc"
    t.float    "senac"
    t.float    "decimo_terceito"
    t.float    "um_terco_constitucional"
    t.float    "ferias"
    t.float    "pct_inss_sob_soma_decimo_um_terco_ferias"
    t.float    "pct_fgts_sob_soma_decimo_um_terco_ferias"
    t.float    "aviso_previo"
    t.float    "indenizacao_fgts"
    t.float    "indiceOperacional"
    t.float    "indiceAdministrativo"
    t.float    "valorIndiceAdministrativo"
    t.float    "valorIndiceOperacional"
    t.float    "horasDeCalculoAdNoturno"
    t.float    "coberturas"
    t.float    "aviso_previo_hx"
    t.float    "ferias_h_ex"
    t.float    "ferias_um_terco_constitucional"
    t.float    "aux_enfermidade"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  create_table "cities", force: :cascade do |t|
    t.string   "nome"
    t.float    "feriado"
    t.float    "valeTransporte"
    t.float    "issqn"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "companies", force: :cascade do |t|
    t.string   "name_company"
    t.float    "irrf"
    t.float    "csll"
    t.float    "pis"
    t.float    "cofins"
    t.float    "seguro_aci_trabalho"
    t.float    "pct_reserva_tecnica"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "equipaments", force: :cascade do |t|
    t.string   "fornecedor"
    t.integer  "type_equipament_id"
    t.integer  "sub_type_id"
    t.string   "name_equipament"
    t.string   "marca_mod"
    t.integer  "rec_manutencao"
    t.float    "valor"
    t.float    "depreciacao"
    t.text     "obs_equipament"
    t.datetime "updated_date_valor"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "control_print"
  end

  add_index "equipaments", ["sub_type_id"], name: "index_equipaments_on_sub_type_id", using: :btree
  add_index "equipaments", ["type_equipament_id"], name: "index_equipaments_on_type_equipament_id", using: :btree

  create_table "hour_extra_roles", force: :cascade do |t|
    t.integer  "proposal_hour_extra_id"
    t.integer  "role_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "cargo"
    t.float    "salario"
    t.float    "salario_um_cargo"
    t.integer  "qtd_postos"
  end

  add_index "hour_extra_roles", ["proposal_hour_extra_id"], name: "index_hour_extra_roles_on_proposal_hour_extra_id", using: :btree
  add_index "hour_extra_roles", ["role_id"], name: "index_hour_extra_roles_on_role_id", using: :btree

  create_table "meals", force: :cascade do |t|
    t.string   "type"
    t.float    "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "periods", force: :cascade do |t|
    t.string   "periodo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "proposal_equipaments", force: :cascade do |t|
    t.integer  "type_equipament_id"
    t.integer  "sub_type_id"
    t.integer  "equipament_id"
    t.integer  "proposal_id"
    t.string   "name_equipament"
    t.float    "quantidade"
    t.float    "depreciacao_aux"
    t.float    "valor_equipament"
    t.float    "valor_depreciado"
    t.float    "depreciacao_valida"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.float    "valorEquipSub"
  end

  add_index "proposal_equipaments", ["equipament_id"], name: "index_proposal_equipaments_on_equipament_id", using: :btree
  add_index "proposal_equipaments", ["proposal_id"], name: "index_proposal_equipaments_on_proposal_id", using: :btree
  add_index "proposal_equipaments", ["sub_type_id"], name: "index_proposal_equipaments_on_sub_type_id", using: :btree
  add_index "proposal_equipaments", ["type_equipament_id"], name: "index_proposal_equipaments_on_type_equipament_id", using: :btree

  create_table "proposal_hour_extras", force: :cascade do |t|
    t.string   "client"
    t.string   "detail"
    t.string   "codigo_cliente"
    t.integer  "city_id"
    t.integer  "company_id"
    t.integer  "admin_id"
    t.float    "salario"
    t.float    "n_funcionario"
    t.float    "horas_extras"
    t.float    "ad_noturno"
    t.float    "reflexos"
    t.float    "calc_horas_extras"
    t.float    "calc_ad_noturno"
    t.float    "calc_reflexos"
    t.float    "calc_remuneracao_base_p_func"
    t.float    "calc_total_salario"
    t.float    "acumulador_funcionarios"
    t.float    "remuneracao_base_p_func"
    t.float    "total_funcionarios"
    t.float    "total_salario"
    t.float    "efetivo_total"
    t.float    "efetivo_indivitual"
    t.float    "b_fgts"
    t.float    "b_inss"
    t.float    "b_seg_acidente_trabalho"
    t.float    "b_sebrae"
    t.float    "b_incra"
    t.float    "b_salario_educacao"
    t.float    "b_sesc"
    t.float    "b_senac"
    t.float    "b_total_incargos_diretos"
    t.float    "c_ferias"
    t.float    "c_ferias_um_terco_constitucional"
    t.float    "c_decimo_terceiro_salario"
    t.float    "c_fgts"
    t.float    "c_inss"
    t.float    "c_auxilio_enfermidade"
    t.float    "c_aviso_previo"
    t.float    "c_fgts_indenizado"
    t.float    "c_cooberturas"
    t.float    "c_total_previsões"
    t.float    "d_uni_vr"
    t.float    "d_vr"
    t.float    "d_uni_vt"
    t.float    "d_vt"
    t.float    "tot_beneficios"
    t.float    "tot_mao_de_obra_parcial"
    t.float    "gestao_operacional"
    t.float    "gestao_administrativa"
    t.float    "operacional_administrativo"
    t.float    "seguro_aci_trabalho"
    t.float    "irrf"
    t.float    "csll"
    t.float    "inss"
    t.float    "pis"
    t.float    "cofins"
    t.float    "tot_impostos_sob_servico"
    t.float    "valor_servico"
    t.float    "valor_hora"
    t.float    "valor_total"
    t.float    "qtd_postos"
    t.float    "v_hora_base"
    t.float    "intermunicipal"
    t.float    "tx_opracional"
    t.float    "taxa_operacional"
    t.float    "tx_administrativa"
    t.float    "taxa_administrativo"
    t.float    "n_horas_extras"
    t.float    "v_hora_proposta"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.string   "tipo_servico"
    t.string   "user_criate"
    t.string   "user_update"
    t.string   "tipo_escala"
    t.string   "cidade"
  end

  add_index "proposal_hour_extras", ["admin_id"], name: "index_proposal_hour_extras_on_admin_id", using: :btree
  add_index "proposal_hour_extras", ["city_id"], name: "index_proposal_hour_extras_on_city_id", using: :btree
  add_index "proposal_hour_extras", ["company_id"], name: "index_proposal_hour_extras_on_company_id", using: :btree

  create_table "proposal_roles", force: :cascade do |t|
    t.float    "qtd_postos"
    t.string   "cargo"
    t.float    "salario"
    t.float    "gratificacao"
    t.integer  "proposal_id"
    t.integer  "role_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "proposal_roles", ["proposal_id"], name: "index_proposal_roles_on_proposal_id", using: :btree
  add_index "proposal_roles", ["role_id"], name: "index_proposal_roles_on_role_id", using: :btree

  create_table "proposals", force: :cascade do |t|
    t.string   "user_criate"
    t.string   "cliente"
    t.string   "codigo_cliente"
    t.integer  "admin_id"
    t.integer  "city_id"
    t.integer  "company_id"
    t.integer  "rotation_id"
    t.integer  "role_id"
    t.integer  "period_id"
    t.integer  "adcional_periculosidade_insalubridade"
    t.float    "grau_de_insalubridade"
    t.float    "indice_retorno"
    t.float    "taxa_admin"
    t.float    "intermunicipal"
    t.float    "h_feriado"
    t.string   "user_updated"
    t.float    "teste1"
    t.float    "teste2"
    t.float    "teste3"
    t.float    "teste4"
    t.string   "teste5"
    t.integer  "controle_hora_extra"
    t.integer  "h_extra_jornada_all"
    t.integer  "dias_jornada_ex_semana_all"
    t.integer  "h_ex_jornada_all"
    t.integer  "m_ex_jornada_all"
    t.integer  "h_ex_feriado_jornada_all"
    t.float    "hora_extra_feriado_all"
    t.integer  "h_extra_jornada_matu"
    t.integer  "dias_ex_semana_matu"
    t.integer  "h_ex_jornada_matu"
    t.integer  "m_ex_jornada_matu"
    t.integer  "h_ex_feriado_jornada_matu"
    t.integer  "h_extra_jornada_vesp"
    t.integer  "dias_ex_semana_vesp"
    t.integer  "m_ex_jornada_vesp"
    t.integer  "h_ex_jornada_vesp"
    t.integer  "h_ex_feriado_jornada_vesp"
    t.integer  "h_extra_jornada_notur"
    t.integer  "dias_ex_semana_notur"
    t.integer  "h_ex_jornada_notur"
    t.integer  "m_ex_jornada_notur"
    t.integer  "h_ex_feriado_jornada_notur"
    t.float    "horas_mes"
    t.float    "horas_extras"
    t.integer  "controle_vr"
    t.integer  "vr_all"
    t.integer  "dias_pg_vr_semana_all"
    t.integer  "dias_pg_vr_feriado_all"
    t.integer  "vr_matu"
    t.integer  "dias_pg_vr_semana_matu"
    t.integer  "dias_pg_vr_feriado_matu"
    t.integer  "vr_vesp"
    t.integer  "dias_pg_vr_semana_vesp"
    t.integer  "dias_pg_vr_feriado_vesp"
    t.integer  "vr_notur"
    t.integer  "dias_pg_vr_semana_notur"
    t.integer  "dias_pg_vr_feriado_notur"
    t.float    "qtd_vr_pagas"
    t.float    "qtd_vt_pagas"
    t.integer  "controle_vt"
    t.integer  "vt_all"
    t.integer  "dias_pg_vt_semana_all"
    t.integer  "dias_pg_vt_feriado_all"
    t.integer  "vt_matu"
    t.integer  "dias_pg_vt_semana_matu"
    t.integer  "dias_pg_vt_feriado_matu"
    t.integer  "vt_vesp"
    t.integer  "dias_pg_vt_semana_vesp"
    t.integer  "dias_pg_vt_feriado_vesp"
    t.integer  "vt_notur"
    t.integer  "dias_pg_vt_semana_notur"
    t.integer  "dias_pg_vt_feriado_notur"
    t.float    "total_equipamento"
    t.float    "equipament_nome"
    t.float    "equipament_valor"
    t.float    "equipament_depreciacao"
    t.float    "reserva_operacional_adminstrativo"
    t.float    "valor_passagem"
    t.float    "show_horas"
    t.float    "salario"
    t.float    "qtd_postos"
    t.float    "total_salarios"
    t.float    "multiplicador"
    t.float    "efetivo_total"
    t.float    "total_funcionarios"
    t.float    "efetivo_indivitual"
    t.float    "acumulador_funcionarios"
    t.float    "valor_uni_assist_medica"
    t.float    "valor_unitario_uniforme"
    t.float    "valor_unitario_vr"
    t.float    "valor_unitario_ppr"
    t.float    "valor_unitario_seg_vida"
    t.string   "tipo_servico"
    t.float    "valor_cesta"
    t.float    "valor_ben_natalidade"
    t.float    "valor_soc_familiar"
    t.float    "valor_peri_ou_isalubri"
    t.float    "um_terco"
    t.float    "dois_terco"
    t.float    "horas_vespertino"
    t.float    "total_hrs_ad_noturno_vespertino"
    t.float    "total_hrs_ad_noturno"
    t.float    "valor_feriados_de_cities_mv"
    t.float    "valor_feriados_de_cities_n"
    t.float    "total_hr_extras"
    t.float    "total_hr_extras_feriado"
    t.float    "refexo_dsr"
    t.float    "salario_medio_final"
    t.float    "massa_salarial"
    t.float    "obg_fgts"
    t.float    "obg_inss"
    t.float    "seguro_aci_trabalho"
    t.float    "obgseguro_aci_trabalho"
    t.float    "obg_sebrae"
    t.float    "obg_incra"
    t.float    "obg_salario_educacao"
    t.float    "obg_sesc"
    t.float    "obg_senac"
    t.float    "ajuste_div_por_zero"
    t.float    "total_incargos_diretos"
    t.float    "total_ferias_um_doze_avos"
    t.float    "total_um_terco_consti_um_doze_avos"
    t.float    "total_decimo_terceiro_um_doze_avos"
    t.float    "total_inss_sob_ferias_um_terco_decimo"
    t.float    "total_fgts_sob_ferias_Um_terco_decimo"
    t.float    "total_aviso_previo"
    t.float    "total_indenizacao_sobre_fgts"
    t.float    "total_provisao_massa_salarial"
    t.float    "total_cesta"
    t.float    "total_vr"
    t.float    "tot_social_familiar"
    t.float    "tot_ben_natalidade"
    t.float    "total_assitecia_medica"
    t.float    "total_seguro_vida"
    t.float    "total_vt"
    t.float    "total_reciclagem"
    t.float    "total_ppr"
    t.float    "total_uniforme"
    t.float    "total_beneficios"
    t.float    "total_mao_de_obra"
    t.float    "reserva_tecnica"
    t.float    "reserva_tecnica_old"
    t.float    "tot_parcial_proposta"
    t.float    "pct_total"
    t.float    "pct_total_alicota"
    t.float    "valor_de_calculo_total"
    t.float    "valor_indice_operacional"
    t.float    "valor_indice_administrativo"
    t.float    "valor_issqn"
    t.float    "valor_pis"
    t.float    "valor_cofins"
    t.float    "valor_csll"
    t.float    "valor_irrf"
    t.float    "total_imposto_sob_servico"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.float    "valor_horas_proposta"
    t.float    "valor_dia_proposta"
    t.float    "tot_com_reserva_indce_op_indice_adm"
    t.float    "total_para_ajuste"
    t.float    "valor_de_ajuste"
    t.float    "txopracional"
    t.float    "txadministrativa"
    t.float    "v_calc"
  end

  add_index "proposals", ["admin_id"], name: "index_proposals_on_admin_id", using: :btree
  add_index "proposals", ["city_id"], name: "index_proposals_on_city_id", using: :btree
  add_index "proposals", ["company_id"], name: "index_proposals_on_company_id", using: :btree
  add_index "proposals", ["period_id"], name: "index_proposals_on_period_id", using: :btree
  add_index "proposals", ["role_id"], name: "index_proposals_on_role_id", using: :btree
  add_index "proposals", ["rotation_id"], name: "index_proposals_on_rotation_id", using: :btree

  create_table "roles", force: :cascade do |t|
    t.string   "cargo"
    t.float    "salario"
    t.float    "gratificacao"
    t.float    "vale_refeicao"
    t.float    "assist_medica"
    t.float    "seg_vida"
    t.float    "uniformes"
    t.float    "assist_Soc_Familiar"
    t.float    "beneficio_Natalidade"
    t.float    "ppr"
    t.integer  "service_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "reciclagem"
  end

  add_index "roles", ["service_id"], name: "index_roles_on_service_id", using: :btree

  create_table "rotations", force: :cascade do |t|
    t.string   "tipo_escala"
    t.float    "dias_trabalhados"
    t.float    "qtd_funcionarios"
    t.float    "efetivo"
    t.float    "v_reciclagem"
    t.float    "fator_escala"
    t.integer  "period_id"
    t.float    "ad_vespertido_noturno"
    t.float    "ad_noturno"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "rotations", ["period_id"], name: "index_rotations_on_period_id", using: :btree

  create_table "services", force: :cascade do |t|
    t.string   "tipo_servico"
    t.integer  "company_id"
    t.float    "desconto_vr"
    t.float    "cesta"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "services", ["company_id"], name: "index_services_on_company_id", using: :btree

  create_table "sub_types", force: :cascade do |t|
    t.string   "name_sub_type"
    t.integer  "type_equipament_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "sub_types", ["type_equipament_id"], name: "index_sub_types_on_type_equipament_id", using: :btree

  create_table "type_equipaments", force: :cascade do |t|
    t.string   "name_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "equipaments", "sub_types"
  add_foreign_key "equipaments", "type_equipaments"
  add_foreign_key "hour_extra_roles", "proposal_hour_extras"
  add_foreign_key "hour_extra_roles", "roles"
  add_foreign_key "proposal_equipaments", "equipaments"
  add_foreign_key "proposal_equipaments", "proposals"
  add_foreign_key "proposal_equipaments", "sub_types"
  add_foreign_key "proposal_equipaments", "type_equipaments"
  add_foreign_key "proposal_hour_extras", "admins"
  add_foreign_key "proposal_hour_extras", "cities"
  add_foreign_key "proposal_hour_extras", "companies"
  add_foreign_key "proposal_roles", "proposals"
  add_foreign_key "proposal_roles", "roles"
  add_foreign_key "proposals", "admins"
  add_foreign_key "proposals", "cities"
  add_foreign_key "proposals", "companies"
  add_foreign_key "proposals", "periods"
  add_foreign_key "proposals", "roles"
  add_foreign_key "proposals", "rotations"
  add_foreign_key "roles", "services"
  add_foreign_key "rotations", "periods"
  add_foreign_key "services", "companies"
  add_foreign_key "sub_types", "type_equipaments"
end
