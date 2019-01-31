class CreateProposalHourExtras < ActiveRecord::Migration
  def change
    create_table :proposal_hour_extras do |t|
      t.string :client
      t.string :detail
      t.string :codigo_cliente 
      
      t.references :city, index: true, foreign_key: true
      t.references :company, index: true, foreign_key: true
      t.references :admin, index: true, foreign_key: true

      t.float :salario
      t.float :n_funcionario
      t.float :horas_extras
      t.float :ad_noturno
      t.float :reflexos
      t.float :calc_horas_extras
      t.float :calc_ad_noturno
      t.float :calc_reflexos
      t.float :calc_remuneracao_base_p_func
      t.float :calc_total_salario
      t.float :acumulador_funcionarios
      t.float :remuneracao_base_p_func
      t.float :total_funcionarios
      t.float :total_salario
      t.float :efetivo_total
      t.float :efetivo_indivitual
      t.float :b_fgts
      t.float :b_inss
      t.float :b_seg_acidente_trabalho
      t.float :b_sebrae
      t.float :b_incra
      t.float :b_salario_educacao
      t.float :b_sesc
      t.float :b_senac
      t.float :b_total_incargos_diretos
      t.float :c_ferias 
      t.float :c_ferias_um_terco_constitucional 
      t.float :c_decimo_terceiro_salario
      t.float :c_fgts
      t.float :c_inss
      t.float :c_auxilio_enfermidade 
      t.float :c_aviso_previo
      t.float :c_fgts_indenizado
      t.float :c_cooberturas
      t.float :c_total_previsões
      t.float :d_uni_vr
      t.float :d_vr
      t.float :d_uni_vt
      t.float :d_vt
      t.float :tot_beneficios
      t.float :tot_mao_de_obra_parcial
      t.float :gestao_operacional
      t.float :gestao_administrativa
      t.float :operacional_administrativo
      t.float :seguro_aci_trabalho
      t.float :irrf
      t.float :csll
      t.float :inss
      t.float :pis 
      t.float :cofins
      t.float :tot_impostos_sob_servico
      t.float :valor_servico
      t.float :valor_hora
      t.float :valor_total
      t.float :qtd_postos
      t.float :v_hora_base
      t.float :intermunicipal
      t.float :tx_opracional
      t.float :taxa_operacional
      t.float :tx_administrativa
      t.float :taxa_administrativo
      t.float :n_horas_extras
      t.float :v_hora_proposta

      t.timestamps null: false
    end
  end
end
