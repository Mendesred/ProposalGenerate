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
      t.float :hora_extra_feriado_all
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
      
      t.float :valor_passagem

      t.float :salario
      t.float :qtd_postos
      t.float :totalSalarios
      t.float :multiplicador
      t.float :efetivoTotal
      t.float :totalFuncionarios
      t.float :efetivoIndivitual
      t.float :acumuladorFuncionarios
      t.float :vUniAssistMedica
      t.float :vUniUniforme
      t.float :vUniVR
      t.float :vUniPpr
      t.float :vUniSegVida
      t.string :tipo_servico
      t.float :v_cesta
      t.float :v_ben_Natalidade
      t.float :v_Soc_Familiar
      t.float :valorPeriOuIsalubri
      t.float :ajusteDivPorZero
      t.float :umTerco
      t.float :doisTerco
      t.float :horas_vespertino
      t.float :totalHrsAdNoturnoVespertino
      t.float :totalHrsAdNoturno
      t.float :vFeriadosDeCitiesMV
      t.float :vFeriadosDeCitiesN
      t.float :totalHrExtras
      t.float :totalHrExtrasFeriado
      t.float :refexoDSR
      t.float :salarioMedioFinal
      t.float :massaSalarial
      t.float :obgFGTS
      t.float :obgINSS
      t.float :seguro_aci_trabalho
      t.float :obgseguro_aci_trabalho
      t.float :obgsebrae
      t.float :obgincra
      t.float :obgsalario_educacao
      t.float :obgsesc
      t.float :obgsenac
      t.float :totalIncargosDiretos
      t.float :totalferiasUmDozeAvos
      t.float :totalumTercoConstiUmDozeAvos
      t.float :totaldecimoTerceiroUmDozeAvos
      t.float :totalInssSobFeriasUnTercoDecimo
      t.float :totalFgtsSobFeriasUnTercoDecimo
      t.float :totalAvisoPrevio
      t.float :totalIndenizacaoSobreFGTS
      t.float :totalProvisaoMassaSalarial
      t.float :totCesta
      t.float :totVR
      t.float :totSocialFamiliar
      t.float :totBenNatalidade 
      t.float :totAssiteciaMedica 
      t.float :totSeguroVida 
      t.float :totVT 
      t.float :totReciclagem
      t.float :totPpr 
      t.float :totUniforme 
      t.float :totBeneficios 
      t.float :totMaoDeObra
      t.float :reservaTecnica
      t.float :reserva_tecnica_old
      t.float :totParcialProposta
      t.float :pctTotal
      t.float :pctTotalAlicota
      t.float :vDeCalculoTotal
      t.float :valorIndiceOperacional
      t.float :valorIndiceAdministrativo
      t.float :valorIssqn
      t.float :valorPis
      t.float :valorCofins
      t.float :valorCsll
      t.float :valorIrrf
      t.float :totImpostoSobServico


      t.timestamps null: false
    end
  end
end
