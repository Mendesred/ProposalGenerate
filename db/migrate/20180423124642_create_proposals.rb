class CreateProposals < ActiveRecord::Migration
  def change
    create_table :proposals do |t|
      t.string :user_criate
      t.string :cliente
      t.string :codigo_cliente
      t.references :admin, index: true, foreign_key: true
      t.references :city, index: true, foreign_key: true
      t.references :company, index: true, foreign_key: true
      t.references :rotation, index: true, foreign_key: true
      t.references :equipament, index: true, foreign_key: true
      t.references :role, index: true, foreign_key: true
      t.references :period, index: true, foreign_key: true
      t.integer :adcional_periculosidade_insalubridade
      t.float :grau_de_insalubridade
      t.float :indice_retorno
      t.float :taxa_admin
      t.float :intermunicipal
      t.float :h_feriado
      t.string :user_updated


      ### APAGAR ###
      t.float :teste1
      t.float :teste2
      t.float :teste3
      t.float :teste4
      t.string :teste5

      ###################################################
      ### colunas para horas extras,vr e vt           ###
      ###################################################
      #para horas extras todos os periodos
      t.integer :controle_hora_extra

      t.integer :h_extra_jornada_all
      t.integer :dias_jornada_ex_semana_all
      t.integer :h_ex_jornada_all
      t.integer :m_ex_jornada_all
      t.integer :h_ex_feriado_jornada_all

      t.float :hora_extra_feriado_all

      #para horas extras matutino
      t.integer :h_extra_jornada_matu
      t.integer :dias_ex_semana_matu
      t.integer :h_ex_jornada_matu
      t.integer :m_ex_jornada_matu
      t.integer :h_ex_feriado_jornada_matu

      #para horas extras vespertino
      t.integer :h_extra_jornada_vesp
      t.integer :dias_ex_semana_vesp
      t.integer :m_ex_jornada_vesp
      t.integer :h_ex_jornada_vesp
      t.integer :h_ex_feriado_jornada_vesp

      #para horas extras Noturno
      t.integer :h_extra_jornada_notur
      t.integer :dias_ex_semana_notur
      t.integer :h_ex_jornada_notur
      t.integer :m_ex_jornada_notur
      t.integer :h_ex_feriado_jornada_notur

      t.float :horas_mes
      t.float :horas_extras
      ######################################
      # VR all
      t.integer :controle_vr

      t.integer :vr_all
      t.integer :dias_pg_vr_semana_all
      t.integer :dias_pg_vr_feriado_all
      # VR Matutino
      t.integer :vr_matu
      t.integer :dias_pg_vr_semana_matu
      t.integer :dias_pg_vr_feriado_matu
      # VR Vespertino
      t.integer :vr_vesp
      t.integer :dias_pg_vr_semana_vesp
      t.integer :dias_pg_vr_feriado_vesp
      # VR Noturno
      t.integer :vr_notur
      t.integer :dias_pg_vr_semana_notur
      t.integer :dias_pg_vr_feriado_notur

      t.float :qtd_vr_pagas
      t.float :qtd_vt_pagas
      ######################################
      # VT all
      t.integer :controle_vt

      t.integer :vt_all
      t.integer :dias_pg_vt_semana_all
      t.integer :dias_pg_vt_feriado_all
      # VT Matutino
      t.integer :vt_matu
      t.integer :dias_pg_vt_semana_matu
      t.integer :dias_pg_vt_feriado_matu
      # VT Vespertino
      t.integer :vt_vesp
      t.integer :dias_pg_vt_semana_vesp
      t.integer :dias_pg_vt_feriado_vesp
      # VT Noturno
      t.integer :vt_notur
      t.integer :dias_pg_vt_semana_notur
      t.integer :dias_pg_vt_feriado_notur


      ###################################################
      ### Abaxo campos salvos por calculo na proposta ###
      ###################################################
      t.float :total_equipamento
      t.float :equipament_nome
      t.float :equipament_valor
      t.float :equipament_depreciacao
      #t.float :gratificacao
      
      t.float :reserva_operacional_adminstrativo
      t.float :valor_passagem
      t.float :show_horas

      t.float :salario
      t.float :qtd_postos
      t.float :total_salarios
      t.float :multiplicador
      t.float :efetivo_total
      t.float :total_funcionarios
      t.float :efetivo_indivitual
      t.float :acumulador_funcionarios
      t.float :valor_uni_assist_medica
      t.float :valor_unitario_uniforme
      t.float :valor_unitario_vr
      t.float :valor_unitario_ppr
      t.float :valor_unitario_seg_vida
      t.string :tipo_servico
      t.float :valor_cesta
      t.float :valor_ben_natalidade
      t.float :valor_soc_familiar
      t.float :valor_peri_ou_isalubri
      t.float :um_terco
      t.float :dois_terco
      t.float :horas_vespertino
      t.float :total_hrs_ad_noturno_vespertino
      t.float :total_hrs_ad_noturno
      t.float :valor_feriados_de_cities_mv
      t.float :valor_feriados_de_cities_n
      t.float :total_hr_extras
      t.float :total_hr_extras_feriado
      t.float :refexo_dsr
      t.float :salario_medio_final
      t.float :massa_salarial
      t.float :obg_fgts
      t.float :obg_inss
      t.float :seguro_aci_trabalho
      t.float :obgseguro_aci_trabalho
      t.float :obg_sebrae
      t.float :obg_incra
      t.float :obg_salario_educacao
      t.float :obg_sesc
      t.float :obg_senac
      t.float :ajuste_div_por_zero
      t.float :total_incargos_diretos
      t.float :total_ferias_um_doze_avos
      t.float :total_um_terco_consti_um_doze_avos
      t.float :total_decimo_terceiro_um_doze_avos
      t.float :total_inss_sob_ferias_um_terco_decimo
      t.float :total_fgts_sob_ferias_Um_terco_decimo
      t.float :total_aviso_previo
      t.float :total_indenizacao_sobre_fgts
      t.float :total_provisao_massa_salarial
      t.float :total_cesta
      t.float :total_vr
      t.float :tot_social_familiar
      t.float :tot_ben_natalidade 
      t.float :total_assitecia_medica 
      t.float :total_seguro_vida 
      t.float :total_vt 
      t.float :total_reciclagem
      t.float :total_ppr 
      t.float :total_uniforme 
      t.float :total_beneficios 
      t.float :total_mao_de_obra
      t.float :reserva_tecnica
      t.float :reserva_tecnica_old
      t.float :tot_parcial_proposta
      t.float :pct_total
      t.float :pct_total_alicota
      t.float :valor_de_calculo_total
      t.float :valor_indice_operacional
      t.float :valor_indice_administrativo
      t.float :valor_issqn
      t.float :valor_pis
      t.float :valor_cofins
      t.float :valor_csll
      t.float :valor_irrf
      t.float :total_imposto_sob_servico


      t.timestamps null: false
    end
  end
end
