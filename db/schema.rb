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

ActiveRecord::Schema.define(version: 20180626181857) do

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

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true

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
    t.string   "name_equipament"
    t.float    "valor"
    t.float    "depreciacao"
    t.integer  "proposal_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "equipaments", ["proposal_id"], name: "index_equipaments_on_proposal_id"

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
    t.integer  "equipament_id"
    t.integer  "proposal_id"
    t.float    "name_equipament"
    t.float    "quantidade"
    t.float    "valor_equipament"
    t.float    "valor_depreciado"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "proposal_equipaments", ["equipament_id"], name: "index_proposal_equipaments_on_equipament_id"
  add_index "proposal_equipaments", ["proposal_id"], name: "index_proposal_equipaments_on_proposal_id"

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

  add_index "proposal_roles", ["proposal_id"], name: "index_proposal_roles_on_proposal_id"
  add_index "proposal_roles", ["role_id"], name: "index_proposal_roles_on_role_id"

  create_table "proposals", force: :cascade do |t|
    t.string   "user_criate"
    t.string   "cliente"
    t.string   "codigo_cliente"
    t.integer  "admin_id"
    t.integer  "city_id"
    t.integer  "company_id"
    t.integer  "rotation_id"
    t.integer  "equipament_id"
    t.integer  "role_id"
    t.integer  "period_id"
    t.integer  "adcional_periculosidade_insalubridade"
    t.float    "grau_de_insalubridade"
    t.float    "indice_retorno"
    t.float    "taxa_admin"
    t.float    "intermunicipal"
    t.float    "h_feriado"
    t.string   "user_updated"
    t.float    "hora_extra_feriado_all"
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
    t.integer  "h_extra_refeicao_all"
    t.integer  "dias_refeicao_ex_semana_all"
    t.integer  "h_refeicao_ex_feriado_all"
    t.integer  "h_extra_jornada_matu"
    t.integer  "dias_ex_semana_matu"
    t.integer  "h_ex_jornada_matu"
    t.integer  "m_ex_jornada_matu"
    t.integer  "h_ex_feriado_jornada_matu"
    t.integer  "h_extra_refeicao_matu"
    t.integer  "dias_refeicao_ex_semana_matu"
    t.integer  "h_refeicao_ex_feriado_matu"
    t.integer  "h_extra_jornada_vesp"
    t.integer  "dias_ex_semana_vesp"
    t.integer  "m_ex_jornada_vesp"
    t.integer  "h_ex_jornada_vesp"
    t.integer  "h_ex_feriado_jornada_vesp"
    t.integer  "h_extra_refeicao_vesp"
    t.integer  "dias_refeicao_ex_semana_vesp"
    t.integer  "h_refeicao_ex_feriado_vesp"
    t.integer  "h_extra_jornada_notur"
    t.integer  "dias_ex_semana_notur"
    t.integer  "h_ex_jornada_notur"
    t.integer  "m_ex_jornada_notur"
    t.integer  "h_ex_feriado_jornada_notur"
    t.integer  "h_extra_refeicao_notur"
    t.integer  "dias_refeicao_ex_semana_notur"
    t.integer  "h_refeicao_ex_feriado_notur"
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
    t.float    "soma_horas_ex_jorn_refeicao_dia"
    t.float    "soma_horas_ex_jorn_refeicao_noite"
    t.float    "total_equipamento"
    t.float    "equipament_nome"
    t.float    "equipament_valor"
    t.float    "equipament_depreciacao"
    t.float    "valor_passagem"
    t.float    "salario"
    t.float    "qtd_postos"
    t.float    "totalSalarios"
    t.float    "multiplicador"
    t.float    "efetivoTotal"
    t.float    "totalFuncionarios"
    t.float    "efetivoIndivitual"
    t.float    "acumuladorFuncionarios"
    t.float    "vUniAssistMedica"
    t.float    "vUnitReciclagem"
    t.float    "vUniUniforme"
    t.float    "vUniVR"
    t.float    "vUniPpr"
    t.float    "vUniSegVida"
    t.string   "tipo_servico"
    t.float    "v_cesta"
    t.float    "v_ben_Natalidade"
    t.float    "v_Soc_Familiar"
    t.float    "valorPeriOuIsalubri"
    t.float    "ajusteDivPorZero"
    t.float    "umTerco"
    t.float    "doisTerco"
    t.float    "horas_vespertino"
    t.float    "totalHrsAdNoturnoVespertino"
    t.float    "totalHrsAdNoturno"
    t.float    "vFeriadosDeCitiesMV"
    t.float    "vFeriadosDeCitiesN"
    t.float    "totalHrExtras"
    t.float    "totalHrExtrasFeriado"
    t.float    "refexoDSR"
    t.float    "salarioMedioFinal"
    t.float    "massaSalarial"
    t.float    "obgFGTS"
    t.float    "obgINSS"
    t.float    "seguro_aci_trabalho"
    t.float    "obgseguro_aci_trabalho"
    t.float    "obgsebrae"
    t.float    "obgincra"
    t.float    "obgsalario_educacao"
    t.float    "obgsesc"
    t.float    "obgsenac"
    t.float    "totalIncargosDiretos"
    t.float    "totalferiasUmDozeAvos"
    t.float    "totalumTercoConstiUmDozeAvos"
    t.float    "totaldecimoTerceiroUmDozeAvos"
    t.float    "totalInssSobFeriasUnTercoDecimo"
    t.float    "totalFgtsSobFeriasUnTercoDecimo"
    t.float    "totalAvisoPrevio"
    t.float    "totalIndenizacaoSobreFGTS"
    t.float    "totalProvisaoMassaSalarial"
    t.float    "totCesta"
    t.float    "totVR"
    t.float    "totSocialFamiliar"
    t.float    "totBenNatalidade"
    t.float    "totAssiteciaMedica"
    t.float    "totSeguroVida"
    t.float    "totVT"
    t.float    "totReciclagem"
    t.float    "totPpr"
    t.float    "totUniforme"
    t.float    "totBeneficios"
    t.float    "totMaoDeObra"
    t.float    "reservaTecnica"
    t.float    "reserva_tecnica_old"
    t.float    "totParcialProposta"
    t.float    "pctTotal"
    t.float    "pctTotalAlicota"
    t.float    "vDeCalculoTotal"
    t.float    "valorIndiceOperacional"
    t.float    "valorIndiceAdministrativo"
    t.float    "valorIssqn"
    t.float    "valorPis"
    t.float    "valorCofins"
    t.float    "valorCsll"
    t.float    "valorIrrf"
    t.float    "totImpostoSobServico"
    t.float    "totPtoviMassaSalarialComReserva"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  add_index "proposals", ["admin_id"], name: "index_proposals_on_admin_id"
  add_index "proposals", ["city_id"], name: "index_proposals_on_city_id"
  add_index "proposals", ["company_id"], name: "index_proposals_on_company_id"
  add_index "proposals", ["equipament_id"], name: "index_proposals_on_equipament_id"
  add_index "proposals", ["period_id"], name: "index_proposals_on_period_id"
  add_index "proposals", ["role_id"], name: "index_proposals_on_role_id"
  add_index "proposals", ["rotation_id"], name: "index_proposals_on_rotation_id"

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
  end

  add_index "roles", ["service_id"], name: "index_roles_on_service_id"

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

  add_index "rotations", ["period_id"], name: "index_rotations_on_period_id"

  create_table "services", force: :cascade do |t|
    t.string   "tipo_servico"
    t.integer  "company_id"
    t.float    "desconto_vr"
    t.float    "cesta"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "services", ["company_id"], name: "index_services_on_company_id"

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

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
